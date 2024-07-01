//
//  NumberFilter.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct NumberFilter: Codable {
    let hasMinConstraint: Bool
    let hasMaxConstraint: Bool
    let min: Double
    let max: Double
    
    init(hasMinConstraint: Bool, hasMaxConstraint: Bool, min: Double, max: Double) {
        self.hasMinConstraint = hasMinConstraint
        self.hasMaxConstraint = hasMaxConstraint
        self.min = min
        self.max = max
    }
}
