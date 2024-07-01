//
//  DisplayMetrics.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct DisplayMetrics: Codable {
    let widthPx: Int
    let heightPx: Int
    let xDpi: Int
    let yDpi: Int
    
    init(widthPx: Int, heightPx: Int, xDpi: Int, yDpi: Int) {
        self.widthPx = widthPx
        self.heightPx = heightPx
        self.xDpi = xDpi
        self.yDpi = yDpi
    }
}
