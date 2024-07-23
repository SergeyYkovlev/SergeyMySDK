//
//  RegisteredEvent.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct RegisteredEvent: Codable {
    let id: String
    let timestamp: Int
    let identification: String
    let kind: String
    let scope: String
    let severity: String
    let payload: String?
    let starred: Bool?
    let isError: Bool?
    
    init(id: String, timestamp: Int, identification: String, kind: String, scope: String, severity: String, payload: String? = nil, starred: Bool? = nil, isError: Bool? = nil) {
        self.id = id
        self.timestamp = timestamp
        self.identification = identification
        self.kind = kind
        self.scope = scope
        self.severity = severity
        self.payload = payload
        self.starred = starred
        self.isError = isError
    }
}
