//
//  EventSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct EventSummary: Codable {
    let event: RegisteredEvent
    let sessionID: String
    let associatedAccount: AssociatedAccount?
    let device: Device
    
    init(event: RegisteredEvent, sessionID: String, associatedAccount: AssociatedAccount? = nil, device: Device) {
        self.event = event
        self.sessionID = sessionID
        self.associatedAccount = associatedAccount
        self.device = device
    }
}
