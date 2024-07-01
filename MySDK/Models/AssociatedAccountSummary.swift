//
//  AssociatedAccountSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct AssociatedAccountSummary: Codable {
    let id: String?
    let eventsCount: Int?
    let devicesCount: Int?
    
    init(id: String? = nil, eventsCount: Int? = nil, devicesCount: Int? = nil) {
        self.id = id
        self.eventsCount = eventsCount
        self.devicesCount = devicesCount
    }
}
