//
//  LocalDateTimeAdapter.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation

class LocalDateTimeAdapter {
    private let formatter: DateFormatter
    
    init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Используем ISO_LOCAL_DATE_TIME формат
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    func toJson(value: Date) -> String {
        return formatter.string(from: value)
    }
    
    func fromJson(value: String) -> Date? {
        return formatter.date(from: value)
    }
}
