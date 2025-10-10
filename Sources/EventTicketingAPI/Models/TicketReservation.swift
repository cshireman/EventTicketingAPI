//
//  TicketReservation.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Foundation
import Vapor

struct TicketReservation: Content {
    let reservationId: String
    let tickets: [Ticket]
    let expiresAt: Date
    let total: Decimal
}
