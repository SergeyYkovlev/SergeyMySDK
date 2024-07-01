//
//  ProfileSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ProfileSummary: Codable {
    let userName: String
    
    init(userName: String) {
        self.userName = userName
    }
}
