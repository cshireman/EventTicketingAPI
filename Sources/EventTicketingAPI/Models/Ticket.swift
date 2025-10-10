//
//  Ticket.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Foundation
import Vapor

struct Ticket: Content {
    let id: String
    let eventId: String
    let section: String
    let row: String?
    let seat: String?
    let price: Decimal
    let type: TicketType
    let available: Bool
}
