@testable import EventTicketingAPI
import VaporTesting
import Testing

@Suite("Event Ticketing API Tests", .serialized)
struct EventTicketingAPITests {
    private func withApp(_ test: (Application) async throws -> ()) async throws {
        let app = try await Application.make(.testing)
        do {
            try await configure(app)
            try await test(app)
        } catch {
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }
    
    @Test("Health Check Route")
    func healthCheck() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "health", afterResponse: { res async in
                #expect(res.status == .ok)
            })
        }
    }
    
    @Test("Getting all Events")
    func getAllEvents() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "api/v1/events", afterResponse: { res async throws in
                #expect(res.status == .ok)
                let events = try res.content.decode([Event].self)
                #expect(events.count == 3) // Based on MockData
                #expect(events.contains { $0.name == "Summer Music Festival 2025" })
                #expect(events.contains { $0.name == "Comedy Night Live" })
                #expect(events.contains { $0.name == "Tech Conference 2025" })
            })
        }
    }
    
    @Test("Getting a specific Event")
    func getSpecificEvent() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "api/v1/events/evt_1", afterResponse: { res async throws in
                #expect(res.status == .ok)
                let event = try res.content.decode(Event.self)
                #expect(event.id == "evt_1")
                #expect(event.name == "Summer Music Festival 2025")
                #expect(event.venue.name == "Golden Gate Park")
                #expect(event.ticketTypes.count == 2)
            })
        }
    }
    
    @Test("Getting a non-existent Event returns 404")
    func getNonExistentEvent() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "api/v1/events/invalid_id", afterResponse: { res async in
                #expect(res.status == .notFound)
            })
        }
    }
    
    @Test("Searching Events")
    func searchEvents() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "api/v1/events/search?q=music", afterResponse: { res async throws in
                #expect(res.status == .ok)
                let events = try res.content.decode([Event].self)
                #expect(events.count == 1)
                #expect(events.first?.name == "Summer Music Festival 2025")
            })
        }
    }
    
    @Test("Searching Events with no query returns 400")
    func searchEventsWithoutQuery() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "api/v1/events/search", afterResponse: { res async in
                #expect(res.status == .badRequest)
            })
        }
    }
    
    @Test("Getting Tickets for an Event")
    func getEventTickets() async throws {
        try await withApp { app in
            try await app.testing().test(.GET, "api/v1/events/evt_1/tickets", afterResponse: { res async throws in
                #expect(res.status == .ok)
                let tickets = try res.content.decode([Ticket].self)
                #expect(tickets.count == 2) // Two tickets for event evt_1 in MockData
                #expect(tickets.allSatisfy { $0.eventId == "evt_1" })
            })
        }
    }
    
    @Test("Reserving Tickets")
    func reserveTickets() async throws {
        struct ReserveRequest: Content {
            let ticketIDs: [String]
        }
        
        let request = ReserveRequest(ticketIDs: ["tkt_1", "tkt_2"])
        
        try await withApp { app in
            try await app.testing().test(.POST, "api/v1/events/evt_1/reserve", beforeRequest: { req in
                try req.content.encode(request)
            }, afterResponse: { res async throws in
                #expect(res.status == .ok)
                let reservation = try res.content.decode(TicketReservation.self)
                #expect(reservation.tickets.count == 2)
                #expect(reservation.total > 0)
                #expect(reservation.expiresAt > Date())
            })
        }
    }
    
    @Test("Reserving non-existent Tickets returns 404")
    func reserveNonExistentTickets() async throws {
        struct ReserveRequest: Content {
            let ticketIDs: [String]
        }
        
        let request = ReserveRequest(ticketIDs: ["invalid_id"])
        
        try await withApp { app in
            try await app.testing().test(.POST, "api/v1/events/evt_1/reserve", beforeRequest: { req in
                try req.content.encode(request)
            }, afterResponse: { res async in
                #expect(res.status == .notFound)
            })
        }
    }
    
    @Test("Creating an Order")
    func createOrder() async throws {
        struct PurchaseRequest: Content {
            let reservationID: String
            let paymentMethod: PaymentMethod
        }
        
        let paymentMethod = PaymentMethod(type: "credit_card", token: "tok_test_123")
        let request = PurchaseRequest(reservationID: "res_123", paymentMethod: paymentMethod)
        
        try await withApp { app in
            try await app.testing().test(.POST, "api/v1/orders", beforeRequest: { req in
                try req.content.encode(request)
            }, afterResponse: { res async throws in
                #expect(res.status == .ok)
                let order = try res.content.decode(Order.self)
                #expect(order.status == .confirmed)
                #expect(order.total > 0)
                #expect(!order.qrCode.isEmpty)
                #expect(order.tickets.count > 0)
            })
        }
    }
}
