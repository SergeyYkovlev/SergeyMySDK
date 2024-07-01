//
//  Identification.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct Identification: Codable {
    let code: String
    let userIdentification: String?
    
    init(code: String, userIdentification: String? = nil) {
        self.code = code
        self.userIdentification = userIdentification
    }
}
