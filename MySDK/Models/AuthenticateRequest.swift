//
//  AuthenticateRequest.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

/**
 *
 * @param login
 * @param password
 */
struct AuthenticateRequest: Codable {
    let login: String
    let password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
