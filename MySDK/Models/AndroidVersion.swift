//
//  AndroidVersion.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct AndroidVersion: Codable {
    let baseOS: String?
    let previewSdkInt: Int?
    let securityPatch: String?
    let codeName: String
    let incremental: String
    let release: String
    let sdkInt: Int
    
    init(baseOS: String? = nil, previewSdkInt: Int? = nil, securityPatch: String? = nil, codeName: String, incremental: String, release: String, sdkInt: Int) {
        self.baseOS = baseOS
        self.previewSdkInt = previewSdkInt
        self.securityPatch = securityPatch
        self.codeName = codeName
        self.incremental = incremental
        self.release = release
        self.sdkInt = sdkInt
    }
}
