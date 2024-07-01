//
//  EventsRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct EventsRequest: Codable {
    let projectID: String?
    let request: ResourceRequest?
    
    init(projectID: String? = nil, request: ResourceRequest? = nil) {
        self.projectID = projectID
        self.request = request
    }
}
