//
//  ApiClient.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation

// Класс для работы с API-клиентом
class ApiClient {
    let baseUrl: String

    // Константы для заголовков
    static let ContentType = "Content-Type"
    static let Accept = "Accept"
    static let JsonMediaType = "application/json"
    static let FormDataMediaType = "multipart/form-data"
    static let XmlMediaType = "application/xml"
    
    // Значения заголовков по умолчанию
    static var defaultHeaders: [String: String] = [ContentType: JsonMediaType, Accept: JsonMediaType]
    static let jsonHeaders: [String: String] = [ContentType: JsonMediaType, Accept: JsonMediaType]

    // Инициализация с базовым URL
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func request<T: Any>(requestConfig: RequestConfig, body: Any? = nil, responseType: T.Type) -> ApiInfrastructureResponse<T> {
            // Проверка и создание URL
            guard var urlComponents = URLComponents(string: baseUrl) else {
                fatalError("Неверный baseUrl.")
            }
            urlComponents.path = requestConfig.path
            urlComponents.queryItems = requestConfig.query.flatMap { key, values in values.map { URLQueryItem(name: key, value: $0) } }

            guard let url = urlComponents.url else {
                fatalError("Неверный URL.")
            }

            // Объединение заголовков
            var headers = requestConfig.headers.merging(ApiClient.defaultHeaders) { (_, new) in new }

            if headers[ApiClient.ContentType] == nil {
                fatalError("Отсутствует заголовок Content-Type. Это необходимо.")
            }
            if headers[ApiClient.Accept] == nil {
                fatalError("Отсутствует заголовок Accept. Это необходимо.")
            }

            let contentType = headers[ApiClient.ContentType]!.lowercased()
            let accept = headers[ApiClient.Accept]!.lowercased()

            let bodyData: Data?
            if let encodableBody = body as? Encodable {
                bodyData = requestBodyDynamic(encodableBody, mediaType: contentType)
            } else if let fileBody = body as? URL {
                bodyData = try? Data(contentsOf: fileBody)
            } else if let formDataBody = body as? [String: String] {
                bodyData = requestBody(content: formDataBody, mediaType: contentType)
            } else {
                bodyData = nil
            }

            let request = createRequest(url: url, method: requestConfig.method.rawValue, headers: headers, body: bodyData)

            let session = URLSession.shared
            var response: (data: Data?, response: URLResponse?, error: Error?)

            // Выполнение запроса с ожиданием
            let semaphore = DispatchSemaphore(value: 0)

            let task = session.dataTask(with: request) { data, res, err in
                response = (data, res, err)
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()

            // Обработка ответа
            guard let httpResponse = response.response as? HTTPURLResponse else {
                return ApiInfrastructureResponse<T>(responseType: .serverError, statusCode: 500, headers: [:])
            }

            let responseHeaders = httpResponse.allHeaderFields as? [String: [String]] ?? [:]

            switch httpResponse.statusCode {
            case 200...299:
                let responseBody: T? = self.responseBody(body: response.data, mediaType: accept, responseType: responseType)
                return Success(data: responseBody!, statusCode: httpResponse.statusCode, headers: responseHeaders)
            case 100...199:
                return Informational(statusText: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode), statusCode: httpResponse.statusCode, headers: responseHeaders)
            case 300...399:
                return Redirection(statusCode: httpResponse.statusCode, headers: responseHeaders)
            case 400...499:
                let errorBody = response.data != nil ? String(data: response.data!, encoding: .utf8) : nil
                return ClientError(body: errorBody, statusCode: httpResponse.statusCode, headers: responseHeaders)
            default:
                let errorMessage = response.data != nil ? String(data: response.data!, encoding: .utf8) : nil
                return ServerError(message: errorMessage, body: response.data, statusCode: httpResponse.statusCode, headers: responseHeaders)
            }
        }

        private func requestBodyDynamic(_ encodable: Encodable, mediaType: String) -> Data? {
            let encoder = JSONEncoder()
            return try? encoder.encode(encodable)
        }

        private func requestBody(content: [String: String], mediaType: String) -> Data? {
            var components = URLComponents()
            components.queryItems = content.map { URLQueryItem(name: $0.key, value: $0.value) }
            return components.query?.data(using: .utf8)
        }

        private func createRequest(url: URL, method: String, headers: [String: String], body: Data?) -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.allHTTPHeaderFields = headers
            request.httpBody = body
            return request
        }

    private func responseBody<T>(body: Data?, mediaType: String = ApiClient.JsonMediaType, responseType: T.Type) -> T? {
        guard let body = body else { return nil }
        if mediaType == ApiClient.JsonMediaType {
            let decoder = JSONDecoder()
            do {
                if let decodableType = responseType as? Decodable.Type {
                    let decodedObject = try decoder.decode(decodableType, from: body)
                    return decodedObject as? T
                } else {
                    // Если тип T не Decodable, возвращаем тело как Data
                    return body as? T
                }
            } catch {
                print("Ошибка декодирования JSON: \(error)")
                return nil
            }
        } else {
            fatalError("responseBody поддерживает только JSON.")
        }
    }
}

// Вспомогательная структура для обертки Encodable объектов
struct AnyEncodable: Encodable {
    private let encodeClosure: (Encoder) throws -> Void

    init<T: Encodable>(_ wrapped: T) {
        self.encodeClosure = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}
