//
//  PaginationInfo.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct PaginationInfo: Codable {
    let totalPages: Int
    let totalItems: Int
    let page: Int
    
    init(totalPages: Int, totalItems: Int, page: Int) {
        self.totalPages = totalPages
        self.totalItems = totalItems
        self.page = page
    }
}
