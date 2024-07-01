//
//  FilterableListOfProblem.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct FilterableListOfProblem: Codable {
    let pagination: PaginationInfo
    let filters: [ValueFilter]
    let items: [Problem]
}
