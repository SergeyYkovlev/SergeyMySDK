//
//  FilterableListOfAssociatedAccountSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct FilterableListOfAssociatedAccountSummary: Codable {
    let pagination: PaginationInfo
    let filters: [ValueFilter]
    let items: [AssociatedAccountSummary]
    
    init(pagination: PaginationInfo, filters: [ValueFilter], items: [AssociatedAccountSummary]) {
        self.pagination = pagination
        self.filters = filters
        self.items = items
    }
}
