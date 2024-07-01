//
//  RequestConfig.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation
/**
 * Определяет объект конфигурации для данного запроса.
 * ПРИМЕЧАНИЕ: Этот объект не включает 'body', так как
 *             это позволяет кэшировать построенный объект
 *             для многих определений запросов.
 * ПРИМЕЧАНИЕ: Headers - это [String: String], потому что rfc2616 определяет
 *             заголовки с несколькими значениями только как csv.
 */
struct RequestConfig {
    let method: RequestMethod
    let path: String
    let headers: [String: String]
    let query: [String: [String]]
    
    init(method: RequestMethod, path: String, headers: [String: String] = [:], query: [String: [String]] = [:]) {
        self.method = method
        self.path = path
        self.headers = headers
        self.query = query
    }
}
