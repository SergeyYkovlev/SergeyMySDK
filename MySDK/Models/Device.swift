//
//  Device.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct Device: Codable {
    let deviceCode: String
    let os: Int
    let androidInfo: AndroidInfo?
    let iosInfo: IOSInfo?
    
    init(deviceCode: String, os: Int, androidInfo: AndroidInfo? = nil, iosInfo: IOSInfo? = nil) {
        self.deviceCode = deviceCode
        self.os = os
        self.androidInfo = androidInfo
        self.iosInfo = iosInfo
    }
}
