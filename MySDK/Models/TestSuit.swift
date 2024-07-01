//
//  TestSuit.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct TestSuit: Codable {
    let id: String
    let title: String
    let tests: [TestCase]
}
