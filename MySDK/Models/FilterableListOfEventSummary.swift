//
//  FilterableListOfEventSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct FilterableListOfEventSummary: Codable {
    let pagination: PaginationInfo
    let filters: [ValueFilter]
    let items: [EventSummary]
    
    init(pagination: PaginationInfo, filters: [ValueFilter], items: [EventSummary]) {
        self.pagination = pagination
        self.filters = filters
        self.items = items
    }
}
