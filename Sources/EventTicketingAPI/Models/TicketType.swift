//
//  TicketType.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Foundation
import Vapor

struct TicketType: Content {
    public let id: String
    public let name: String
    public let description: String
    public let price: Decimal
    public let availableCount: Int
}
