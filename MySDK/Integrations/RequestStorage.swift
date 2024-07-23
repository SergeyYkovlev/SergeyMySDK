//
//  RequestStorage.swift
//  MySDK
//
//  Created by Creonit on 11.07.2024.
//

import Foundation

struct StoredRequest: Codable {
    let url: URL
    let method: String
    let headers: [String: String]
    let body: Data?
}

class RequestStorage {
    private let storageKey = "storedRequests"
    
    func saveRequest(_ request: URLRequest) {
        var storedRequests = getStoredRequests()
        let storedRequest = StoredRequest(
            url: request.url!,
            method: request.httpMethod!,
            headers: request.allHTTPHeaderFields ?? [:],
            body: request.httpBody
        )
        storedRequests.append(storedRequest)
        saveStoredRequests(storedRequests)
    }
    
    func getStoredRequests() -> [StoredRequest] {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let requests = try? JSONDecoder().decode([StoredRequest].self, from: data) {
            return requests
        }
        return []
    }
    
    private func saveStoredRequests(_ requests: [StoredRequest]) {
        if let data = try? JSONEncoder().encode(requests) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func clearStoredRequests() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
