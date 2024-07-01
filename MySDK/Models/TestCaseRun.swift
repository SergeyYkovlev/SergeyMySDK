//
//  TestCaseRun.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct TestCaseRun {
    let id: String
    let testCase: TestCase
    let status: TestRunStatus
    let steps: [TestStepRun]
    let linkedSessionID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case testCase = "case"
        case status
        case steps
        case linkedSessionID
    }
}
