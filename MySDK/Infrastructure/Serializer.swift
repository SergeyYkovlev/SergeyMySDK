//
//  Serializer.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation
import Foundation

class Serializer {
    static let shared = Serializer()
    let jsonEncoder: JSONEncoder
    let jsonDecoder: JSONDecoder

    private init() {
        jsonEncoder = JSONEncoder()
        jsonDecoder = JSONDecoder()

        // Настройка JSONEncoder и JSONDecoder для поддержки Rfc3339Date
        jsonEncoder.dateEncodingStrategy = .iso8601
        jsonDecoder.dateDecodingStrategy = .iso8601

        // Дополнительные настройки, если требуются
    }
}
