//
//  PaymentMethod.swift
//  EventTicketingSDK
//
//  Created by Chris Shireman on 10/8/25.
//
import Foundation
import Vapor

struct PaymentMethod: Content {
    let type: String
    let token: String
}
