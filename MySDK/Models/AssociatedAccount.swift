//
//  AssociatedAccount.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct AssociatedAccount: Codable {
    let id: String?
    let identification: String?
    
    init(id: String? = nil, identification: String? = nil) {
        self.id = id
        self.identification = identification
    }
}
