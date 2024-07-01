//
//  LiveDeviceUpdate.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct LiveDeviceUpdate: Codable {
    let events: [RegisteredEvent]
    let session: SessionSummary
    
    init(events: [RegisteredEvent], session: SessionSummary) {
        self.events = events
        self.session = session
    }
}
