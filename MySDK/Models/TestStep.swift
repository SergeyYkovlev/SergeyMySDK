//
//  TestStep.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct TestStep: Codable {
    let action: String
    let data: String
    let expected: String
    let attachment: String
}
