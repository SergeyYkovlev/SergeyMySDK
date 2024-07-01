//
//  ResourceRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ResourceRequest: Codable {
    let page: Int?
    let pageSize: Int?
    let filters: [ValueFilter]?
    
    init(page: Int? = nil, pageSize: Int? = nil, filters: [ValueFilter]? = nil) {
        self.page = page
        self.pageSize = pageSize
        self.filters = filters
    }
}
