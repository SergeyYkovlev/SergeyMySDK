//
//  FilterableListOfSessionSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct FilterableListOfSessionSummary: Codable {
    let pagination: PaginationInfo
    let filters: [ValueFilter]
    let items: [SessionSummary]
    
    init(pagination: PaginationInfo, filters: [ValueFilter], items: [SessionSummary]) {
        self.pagination = pagination
        self.filters = filters
        self.items = items
    }
}
