//
//  SuccessAuthResponse.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct SuccessAuthResponse: Codable {
    let jwt: String
    let profileSummary: ProfileSummary
    
    init(jwt: String, profileSummary: ProfileSummary) {
        self.jwt = jwt
        self.profileSummary = profileSummary
    }
}
