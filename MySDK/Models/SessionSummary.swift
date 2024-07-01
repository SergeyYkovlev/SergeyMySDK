//
//  SessionSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct SessionSummary: Codable {
    let id: String
    let eventsCounts: Int
    let device: Device
    let associatedAccount: AssociatedAccount?
    
    init(id: String, eventsCounts: Int, device: Device, associatedAccount: AssociatedAccount? = nil) {
        self.id = id
        self.eventsCounts = eventsCounts
        self.device = device
        self.associatedAccount = associatedAccount
    }
}
