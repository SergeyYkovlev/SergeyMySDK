//
//  SessionFilter.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct SessionFilter: Codable {
    let projectID: String?
    let page: Int?
    let pageSize: Int?
    let deviceID: String?
    let sessionID: String?
    let fromTS: Date?
    let toTS: Date?

    enum CodingKeys: String, CodingKey {
        case projectID
        case page
        case pageSize
        case deviceID
        case sessionID
        case fromTS
        case toTS
    }
}
