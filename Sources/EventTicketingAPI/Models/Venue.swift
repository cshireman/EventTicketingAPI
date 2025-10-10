//
//  Venue.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Foundation
import Vapor

struct Venue: Content {
    let id: String
    let name: String
    let address: String
    let city: String
    let state: String
    let capacity: Int
}
