//
//  DeviceInfo.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct DeviceInfo: Codable {
    let code: String
    let os: Int
    let androidInfo: AndroidInfo?
    let iosInfo: IOSInfo?
}
