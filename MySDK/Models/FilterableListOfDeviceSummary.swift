//
//  FilterableListOfDeviceSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct FilterableListOfDeviceSummary: Codable {
    let pagination: PaginationInfo
    let filters: [ValueFilter]
    let items: [DeviceSummary]
    
    init(pagination: PaginationInfo, filters: [ValueFilter], items: [DeviceSummary]) {
        self.pagination = pagination
        self.filters = filters
        self.items = items
    }
}
