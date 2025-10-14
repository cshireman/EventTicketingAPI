import Vapor

func routes(_ app: Application) throws {
    // GET /api/v1/events
    app.get("api", "v1", "events") { req async throws -> [Event] in
        return MockData.events
    }

    // GET /api/v1/events/:id
    app.get("api", "v1", "events", ":id") { req async throws -> Event in
        guard let id = req.parameters.get("id"),
              let event = MockData.events.first(where: { $0.id == id }) else {
            throw Abort(.notFound, reason: "Event not found")
        }
        return event
    }

    // GET /api/v1/events/search?q=query
    app.get("api", "v1", "events", "search") { req async throws -> [Event] in
        guard let query = try? req.query.get(String.self, at: "q") else {
            throw Abort(.badRequest, reason: "Missing search query")
        }

        let results = MockData.events.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.description.localizedCaseInsensitiveContains(query)
        }

        return results
    }

    // MARK: - Tickets Endpoints

    // GET /api/v1/events/:id/tickets
    app.get("api", "v1", "events", ":id", "tickets") { req async throws -> [Ticket] in
        guard let eventID = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }

        return MockData.tickets.filter { $0.eventId == eventID }
    }

    // POST /api/v1/events/:id/reserve
    app.post("api", "v1", "events", ":id", "reserve") { req async throws -> TicketReservation in
        struct ReserveRequest: Content {
            let ticketIds: [String]
        }

        guard let _ = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }

        let request = try req.content.decode(ReserveRequest.self)

        let tickets = MockData.tickets.filter { request.ticketIds.contains($0.id) }

        guard !tickets.isEmpty else {
            throw Abort(.notFound, reason: "Tickets not found")
        }

        let total = tickets.reduce(Decimal.zero) { $0 + $1.price }

        return TicketReservation(
            reservationId: UUID().uuidString,
            tickets: tickets,
            expiresAt: Date().addingTimeInterval(600), // 10 minutes
            total: total
        )
    }

    // MARK: - Orders Endpoints

    // POST /api/v1/orders
    app.post("api", "v1", "orders") { req async throws -> Order in
        struct PurchaseRequest: Content {
            let reservationId: String
            let paymentMethod: PaymentMethod
        }

        let _ = try req.content.decode(PurchaseRequest.self)

        // Simulate payment processing
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 second delay

        // Create mock order
        let order = Order(
            id: UUID().uuidString,
            tickets: MockData.tickets.prefix(2).map { $0 }, // Mock tickets
            total: Decimal(125.50),
            status: .confirmed,
            purchaseDate: Date(),
            qrCode: "QR_\(UUID().uuidString)"
        )

        return order
    }

    // MARK: - Health Check

    app.get("health") { req async -> HTTPStatus in
        return .ok
    }
}
