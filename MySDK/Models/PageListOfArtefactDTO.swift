//
//  PageListOfArtefactDTO.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import Foundation

struct PageListOfArtefactDTO: Codable {
    let items: [ArtefactDTO]
    let pagination: PaginationInfo
}
