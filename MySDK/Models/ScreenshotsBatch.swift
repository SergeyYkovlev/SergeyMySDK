//
//  ScreenshotsBatch.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ScreenshotsBatch: Codable {
    let framesMaping: [Int]?
    let frames: [String]?
    
    init(framesMaping: [Int]? = nil, frames: [String]? = nil) {
        self.framesMaping = framesMaping
        self.frames = frames
    }
}
