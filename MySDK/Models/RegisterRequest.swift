//
//  RegisterRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct RegisterRequest: Codable {
    let login: String
    let password: String
    let userName: String
    
    init(login: String, password: String, userName: String) {
        self.login = login
        self.password = password
        self.userName = userName
    }
}
