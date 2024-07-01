//
//  TestRunBlueprint.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct TestRunBlueprint: Codable {
    let projectId: String?
    let testIds: [String]?
    let title: String?
}
