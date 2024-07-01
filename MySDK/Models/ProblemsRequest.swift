//
//  ProblemsRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ProblemsRequest: Codable {
    let request: ResourceRequest?
    let projectId: String?
    let isSolved: Bool?
}
