//
//  DateFilter.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct DateFilter: Codable {
    let from: Date?
    let to: Date?
    
    init(from: Date? = nil, to: Date? = nil) {
        self.from = from
        self.to = to
    }
}
