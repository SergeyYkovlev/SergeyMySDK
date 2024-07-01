//
//  TestCase.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
struct TestCase: Codable {
    let id: String
    let title: String
    let preconditions: String
    let postconditions: String
    let steps: [TestStep]?
    let status: TestRunStatus?
}
