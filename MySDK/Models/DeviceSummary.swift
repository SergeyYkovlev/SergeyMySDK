//
//  DeviceSummary.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct DeviceSummary: Codable {
    let deviceCode: String
    let sessionsCount: Int
    let associatedAccountsCount: Int
    let exceptionsCount: Int
    let os: Int
    let androidInfo: AndroidInfo?
    let iosInfo: IOSInfo?
    
    init(deviceCode: String, sessionsCount: Int, associatedAccountsCount: Int, exceptionsCount: Int, os: Int, androidInfo: AndroidInfo? = nil, iosInfo: IOSInfo? = nil) {
        self.deviceCode = deviceCode
        self.sessionsCount = sessionsCount
        self.associatedAccountsCount = associatedAccountsCount
        self.exceptionsCount = exceptionsCount
        self.os = os
        self.androidInfo = androidInfo
        self.iosInfo = iosInfo
    }
}
