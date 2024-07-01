//
//  RelationFilter.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct RelationFilter: Codable {
    let relationPrefix: String?
    let filters: [ValueFilter]?
    
    init(relationPrefix: String? = nil, filters: [ValueFilter]? = nil) {
        self.relationPrefix = relationPrefix
        self.filters = filters
    }
}
