//
//  Order.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Foundation
import Vapor

struct Order: Content {
    let id: String
    let tickets: [Ticket]
    let total: Decimal
    let status: OrderStatus
    let purchaseDate: Date
    let qrCode: String

    enum OrderStatus: String, Content {
        case pending
        case confirmed
        case cancelled
        case refunded
    }
}
