//
//  MockData.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/10/25.
//
import Foundation

enum MockData {
    static let events: [Event] = [
        Event(
            id: "evt_1",
            name: "Summer Music Festival 2025",
            description: "Three days of incredible music featuring top artists",
            venue: Venue(
                id: "ven_1",
                name: "Golden Gate Park",
                address: "501 Stanyan St",
                city: "San Francisco",
                state: "CA",
                capacity: 75000
            ),
            date: ISO8601DateFormatter().date(from: "2025-07-15T18:00:00Z")!,
            doors: ISO8601DateFormatter().date(from: "2025-07-15T16:00:00Z")!,
            imageURL: "https://example.com/festival.jpg",
            ticketTypes: [
                TicketType(
                    id: "tt_1",
                    name: "General Admission",
                    description: "Access to all stages",
                    price: Decimal(199.99),
                    availableCount: 5000
                ),
                TicketType(
                    id: "tt_2",
                    name: "VIP",
                    description: "Premium viewing areas + lounge access",
                    price: Decimal(499.99),
                    availableCount: 500
                )
            ],
            status: "onSale"
        ),
        Event(
            id: "evt_2",
            name: "Comedy Night Live",
            description: "An evening of stand-up comedy",
            venue: Venue(
                id: "ven_2",
                name: "The Laugh Factory",
                address: "3175 Sunset Blvd",
                city: "Los Angeles",
                state: "CA",
                capacity: 400
            ),
            date: ISO8601DateFormatter().date(from: "2025-06-20T20:00:00Z")!,
            doors: ISO8601DateFormatter().date(from: "2025-06-20T19:00:00Z")!,
            imageURL: "https://example.com/comedy.jpg",
            ticketTypes: [
                TicketType(
                    id: "tt_3",
                    name: "Standard",
                    description: "General seating",
                    price: Decimal(45.00),
                    availableCount: 350
                )
            ],
            status: "onSale"
        ),
        Event(
            id: "evt_3",
            name: "Tech Conference 2025",
            description: "Annual technology and innovation summit",
            venue: Venue(
                id: "ven_3",
                name: "Moscone Center",
                address: "747 Howard St",
                city: "San Francisco",
                state: "CA",
                capacity: 15000
            ),
            date: ISO8601DateFormatter().date(from: "2025-09-10T09:00:00Z")!,
            doors: ISO8601DateFormatter().date(from: "2025-09-10T08:00:00Z")!,
            imageURL: "https://example.com/tech.jpg",
            ticketTypes: [
                TicketType(
                    id: "tt_4",
                    name: "3-Day Pass",
                    description: "Full conference access",
                    price: Decimal(899.00),
                    availableCount: 8000
                ),
                TicketType(
                    id: "tt_5",
                    name: "Single Day",
                    description: "One day access",
                    price: Decimal(349.00),
                    availableCount: 5000
                )
            ],
            status: "upcoming"
        )
    ]
    
    static let tickets: [Ticket] = [
        // Summer Music Festival tickets
        Ticket(
            id: "tkt_1",
            eventId: "evt_1",
            section: "GA Floor",
            row: nil,
            seat: nil,
            price: Decimal(199.99),
            type: TicketType(
                id: "tt_1",
                name: "General Admission",
                description: "Access to all stages",
                price: Decimal(199.99),
                availableCount: 5000
            ),
            available: true
        ),
        Ticket(
            id: "tkt_2",
            eventId: "evt_1",
            section: "VIP",
            row: "A",
            seat: "15",
            price: Decimal(499.99),
            type: TicketType(
                id: "tt_2",
                name: "VIP",
                description: "Premium viewing areas + lounge access",
                price: Decimal(499.99),
                availableCount: 500
            ),
            available: true
        ),
        // Comedy Night tickets
        Ticket(
            id: "tkt_3",
            eventId: "evt_2",
            section: "Main Floor",
            row: "C",
            seat: "12",
            price: Decimal(45.00),
            type: TicketType(
                id: "tt_3",
                name: "Standard",
                description: "General seating",
                price: Decimal(45.00),
                availableCount: 350
            ),
            available: true
        ),
        // Tech Conference tickets
        Ticket(
            id: "tkt_4",
            eventId: "evt_3",
            section: "Conference Hall",
            row: nil,
            seat: nil,
            price: Decimal(899.00),
            type: TicketType(
                id: "tt_4",
                name: "3-Day Pass",
                description: "Full conference access",
                price: Decimal(899.00),
                availableCount: 8000
            ),
            available: true
        )
    ]
}
