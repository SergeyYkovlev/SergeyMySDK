//
//  UtsName.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct UtsName: Codable {
    let sysName: String
    let nodeName: String
    let releaseName: String
    let version: String
    let machine: String
    
    init(sysName: String, nodeName: String, releaseName: String, version: String, machine: String) {
        self.sysName = sysName
        self.nodeName = nodeName
        self.releaseName = releaseName
        self.version = version
        self.machine = machine
    }
}
