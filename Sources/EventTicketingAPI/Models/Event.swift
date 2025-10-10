//
//  Event.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Vapor
import Foundation

struct Event: Content {
    let id: String
    let name: String
    let description: String
    let venue: Venue
    let date: Date
    let doors: Date
    let imageURL: String?
    let ticketTypes: [TicketType]
    let status: String
}
