//
//  ProjectInfo.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ProjectInfo: Codable {
    let id: String
    let name: String
    let mineRights: [String]
    let profilePicture: String
}
