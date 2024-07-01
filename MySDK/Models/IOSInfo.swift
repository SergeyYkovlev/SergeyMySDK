//
//  IOSInfo.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct IOSInfo: Codable {
    let isPhysical: Bool
    let localizedModel: String
    let model: String
    let systemVersion: String
    let systemName: String
    let utsName: UtsName
    
    init(isPhysical: Bool, localizedModel: String, model: String, systemVersion: String, systemName: String, utsName: UtsName) {
        self.isPhysical = isPhysical
        self.localizedModel = localizedModel
        self.model = model
        self.systemVersion = systemVersion
        self.systemName = systemName
        self.utsName = utsName
    }
}
