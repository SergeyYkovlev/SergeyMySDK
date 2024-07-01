//
//  TestStepRun.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct TestStepRun: Codable {
    let id: String
    let index: Int
    let status: TestRunStatus
    let step: TestStep
}
