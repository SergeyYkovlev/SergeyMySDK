//
//  ArtefactDTO.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ArtefactDTO: Codable {
    let id: String
    let downloadLink: String?
    let artefactExt: String?
    let environment: String
    let platform: String
    let flavor: String
    let version: String
    let build: Int
    let publication: Date

    enum CodingKeys: String, CodingKey {
        case id
        case downloadLink
        case artefactExt
        case environment
        case platform
        case flavor
        case version
        case build
        case publication
    }
}

// Используем кастомный DateFormatter для преобразования LocalDateTime
extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
