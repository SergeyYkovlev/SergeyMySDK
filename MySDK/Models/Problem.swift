//
//  Problem.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct Problem: Codable {
    let id: String
    let isSolved: Bool
    let lastOccurance: Date
    let totalOccurances: Int
    let affectedDevices: Int
    let kind: String
    let identification: String

    enum CodingKeys: String, CodingKey {
        case id
        case isSolved
        case lastOccurance
        case totalOccurances
        case affectedDevices
        case kind
        case identification
    }
}
