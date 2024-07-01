//
//  PageListOfSessionSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct PageListOfSessionSummary: Codable {
    let items: [SessionSummary]
    let pagination: PaginationInfo
}
