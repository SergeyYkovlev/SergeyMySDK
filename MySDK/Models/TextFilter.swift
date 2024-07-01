//
//  TextFilter.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct TextFilter: Codable {
    let query: String?
    
    init(query: String? = nil) {
        self.query = query
    }
}
