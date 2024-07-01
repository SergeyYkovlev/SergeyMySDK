//
//  ScreenshotsBatch.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ScreenshotsBatch: Codable {
    let framesMapping: [Int]?
    let frames: [String]?
    
    init(framesMapping: [Int]? = nil, frames: [String]? = nil) {
        self.framesMapping = framesMapping
        self.frames = frames
    }
}
