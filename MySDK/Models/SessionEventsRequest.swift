//
//  SessionEventsRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct SessionEventsRequest: Codable {
    let projectID: String?
    let sessionID: String?
    
    init(projectID: String? = nil, sessionID: String? = nil) {
        self.projectID = projectID
        self.sessionID = sessionID
    }
}
