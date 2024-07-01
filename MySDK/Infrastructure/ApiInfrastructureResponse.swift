//
//  ApiInfrastructureResponse.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation

enum ResponseType {
    case success
    case informational
    case redirection
    case clientError
    case serverError
}

class ApiInfrastructureResponse<T> {
    let responseType: ResponseType
    let statusCode: Int
    let headers: [String: [String]]
    let data: T?
    
    init(responseType: ResponseType, statusCode: Int, headers: [String: [String]], data: T? = nil) {
        self.responseType = responseType
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }
}

class Success<T>: ApiInfrastructureResponse<T> {
    init(data: T, statusCode: Int = -1, headers: [String: [String]] = [:]) {
        super.init(responseType: .success, statusCode: statusCode, headers: headers, data: data)
    }
}

class Informational<T>: ApiInfrastructureResponse<T> {
    let statusText: String
    
    init(statusText: String, statusCode: Int = -1, headers: [String: [String]] = [:]) {
        self.statusText = statusText
        super.init(responseType: .informational, statusCode: statusCode, headers: headers)
    }
}

class Redirection<T>: ApiInfrastructureResponse<T> {
    init(statusCode: Int = -1, headers: [String: [String]] = [:]) {
        super.init(responseType: .redirection, statusCode: statusCode, headers: headers)
    }
}

class ClientError<T>: ApiInfrastructureResponse<T> {
    let body: Any?
    
    init(body: Any? = nil, statusCode: Int = -1, headers: [String: [String]] = [:]) {
        self.body = body
        super.init(responseType: .clientError, statusCode: statusCode, headers: headers)
    }
}

class ServerError<T>: ApiInfrastructureResponse<T> {
    let message: String?
    let body: Any?
    
    init(message: String? = nil, body: Any? = nil, statusCode: Int = -1, headers: [String: [String]] = [:]) {
        self.message = message
        self.body = body
        super.init(responseType: .serverError, statusCode: statusCode, headers: headers, data: nil)
    }
}
