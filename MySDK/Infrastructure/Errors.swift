//
//  Errors.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation

// Определение исключения ClientException
open class ClientException: RuntimeException {
    
    // Инициализатор без сообщения
    public override init() {
        super.init()
    }
    
    // Инициализатор с сообщением
    public init(message: String) {
        super.init(message: message)
    }
}

// Определение исключения ServerException
open class ServerException: RuntimeException {
    
    // Инициализатор без сообщения
    public override init() {
        super.init()
    }
    
    // Инициализатор с сообщением
    public init(message: String) {
        super.init(message: message)
    }
}

// Базовый класс RuntimeException
open class RuntimeException: Error, CustomStringConvertible {
    public var message: String?
    
    public init() {}
    
    public init(message: String?) {
        self.message = message
    }
    
    public var description: String {
        return message ?? "RuntimeException"
    }
}
