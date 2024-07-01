//
//  LogScopeURLSessionInterceptor.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import os.log

public class LogScopeURLProtocol: URLProtocol {
    
    public override class func canInit(with request: URLRequest) -> Bool {
        // Определите условия, при которых будет перехватываться запрос
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        logRequest(request)
        
        guard let client = client else {
            return
        }
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                self.logResponse(response, data: data, error: error)
                
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                
                if let data = data {
                    client.urlProtocol(self, didLoad: data)
                }
                
                if let error = error {
                    client.urlProtocol(self, didFailWithError: error)
                } else {
                    client.urlProtocolDidFinishLoading(self)
                }
            }
        }
        task.resume()
    }
    
    public override func stopLoading() {
        // Остановите загрузку, если необходимо
    }
    
    private func logRequest(_ request: URLRequest) {
        var requestLog = [String: Any]()
        requestLog["https"] = request.url?.scheme == "https"
        requestLog["url"] = request.url?.absoluteString ?? ""
        requestLog["method"] = request.httpMethod ?? ""
        
        var requestHeaders = [String: String]()
        request.allHTTPHeaderFields?.forEach { key, value in
            requestHeaders[key] = value
        }
        requestLog["requestHeaders"] = requestHeaders
        
        LogScope.shared.rawLog(identification: "Сетевой запрос", scope: "Главный клиент", kind: "Уведомление", severity: "Отладка", payload: requestLog)
    }
    
    private func logResponse(_ response: HTTPURLResponse, data: Data?, error: Error?) {
        var responseLog = [String: Any]()
        responseLog["https"] = response.url?.scheme == "https"
        responseLog["url"] = response.url?.absoluteString ?? ""
        responseLog["method"] = request.httpMethod ?? ""
        responseLog["status"] = response.statusCode
        responseLog["isRedirect"] = (300...399).contains(response.statusCode)
        
        var responseHeaders = [String: String]()
        response.allHeaderFields.forEach { key, value in
            if let key = key as? String, let value = value as? String {
                responseHeaders[key] = value
            }
        }
        responseLog["responseHeaders"] = responseHeaders
        
        if let error = error {
            responseLog["failedToCall"] = true
            responseLog["exception"] = error.localizedDescription
            LogScope.shared.rawLog(identification: "Ошибка запроса", scope: "Главный клиент", kind: "Уведомление", severity: "Отладка", payload: responseLog)
        } else {
            LogScope.shared.rawLog(identification: "Сетевой запрос", scope: "Главный клиент", kind: "Уведомление", severity: "Отладка", payload: responseLog)
        }
    }
}

//// Usage example
//let config = URLSessionConfiguration.default
//config.protocolClasses = [LogScopeURLProtocol.self]
//let session = URLSession(configuration: config)
//
//let url = URL(string: "https://example.com")!
//var request = URLRequest(url: url)
//request.httpMethod = "GET"
//
//let task = session.dataTask(with: request) { data, response, error in
//    // Handle response
//}
//task.resume()
