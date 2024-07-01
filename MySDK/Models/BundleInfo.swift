//
//  BundleInfo.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct BundleInfo: Codable {
    let version: String?
    let build: String?
    let branch: String?
    
    init(version: String? = nil, build: String? = nil, branch: String? = nil) {
        self.version = version
        self.build = build
        self.branch = branch
    }
}
