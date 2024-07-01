//
//  AndroidInfo.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct AndroidInfo: Codable {
    let id: String
    let host: String
    let manufacturer: String
    let androidVersion: AndroidVersion
    let board: String
    let bootLoader: String
    let brand: String
    let device: String
    let display: DisplayMetrics
    let fingerprint: String
    let hardware: String
    let isPhysical: Bool
    let model: String
    let product: String
    let serialNumber: String
    let supported32BitAbis: [String]
    let supported64BitAbis: [String]
    let supportedAbis: [String]
    let systemFeatures: [String]
    let type: String
    
    init(id: String, host: String, manufacturer: String, androidVersion: AndroidVersion, board: String, bootLoader: String, brand: String, device: String, display: DisplayMetrics, fingerprint: String, hardware: String, isPhysical: Bool, model: String, product: String, serialNumber: String, supported32BitAbis: [String], supported64BitAbis: [String], supportedAbis: [String], systemFeatures: [String], type: String) {
        self.id = id
        self.host = host
        self.manufacturer = manufacturer
        self.androidVersion = androidVersion
        self.board = board
        self.bootLoader = bootLoader
        self.brand = brand
        self.device = device
        self.display = display
        self.fingerprint = fingerprint
        self.hardware = hardware
        self.isPhysical = isPhysical
        self.model = model
        self.product = product
        self.serialNumber = serialNumber
        self.supported32BitAbis = supported32BitAbis
        self.supported64BitAbis = supported64BitAbis
        self.supportedAbis = supportedAbis
        self.systemFeatures = systemFeatures
        self.type = type
    }
}
