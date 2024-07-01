//
//  SessionsRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct SessionsRequest: Codable {
    let projectID: String?
    let deviceId: String?
    let request: ResourceRequest?
    
    init(projectID: String? = nil, deviceId: String? = nil, request: ResourceRequest? = nil) {
        self.projectID = projectID
        self.deviceId = deviceId
        self.request = request
    }
}
