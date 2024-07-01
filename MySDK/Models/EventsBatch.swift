//
//  EventsBatch.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct EventsBatch: Codable {
    let isLive: Bool
    let os: Int?
    let androidInfo: AndroidInfo?
    let iosInfo: IOSInfo?
    let identification: Identification?
    let bundle: BundleInfo
    let screenshotsBatch: ScreenshotsBatch?
    let events: [RegisteredEvent]
    let projectID: String
    
    init(isLive: Bool, os: Int? = nil, androidInfo: AndroidInfo? = nil, iosInfo: IOSInfo? = nil, identification: Identification? = nil, bundle: BundleInfo, screenshotsBatch: ScreenshotsBatch? = nil, events: [RegisteredEvent], projectID: String) {
        self.isLive = isLive
        self.os = os
        self.androidInfo = androidInfo
        self.iosInfo = iosInfo
        self.identification = identification
        self.bundle = bundle
        self.screenshotsBatch = screenshotsBatch
        self.events = events
        self.projectID = projectID
    }
}
