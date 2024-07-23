//
//  ConsumerApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class ConsumerApi: ApiClient {

    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    func consumerChangeStarStatusOfEvents(eventId: String? = nil, starStatus: Bool? = nil) throws {
        var localVariableQuery: [String: [String]] = [:]
        if let eventId = eventId {
            localVariableQuery["eventId"] = [eventId]
        }
        if let starStatus = starStatus {
            localVariableQuery["starStatus"] = [String(starStatus)]
        }
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/consumer/star",
            query: localVariableQuery
        )
        let response: ApiInfrastructureResponse<Any?> = request(
            requestConfig: localVariableConfig, responseType: Any?.self
        )

        switch response.responseType {
        case .success:
            return
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError<Any?>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any?>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param body
     * @return Bool
     */
    func consumerConsumeEvents(body: EventsBatch) throws -> Bool {
//        guard isInternetAvailable() else {
//            throw NSError(domain: "No internet connection", code: 503, userInfo: nil)
//        }

        let localVariableBody: Any? = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/consumer/consume"
        )
        let response: ApiInfrastructureResponse<Bool> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: Bool.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success<Bool>).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError<Bool>).body as? String ?? "Client error")
        case .serverError:
            if let serverError = response as? ServerError<Bool> {
                throw ServerException(message: serverError.message ?? "Server error")
            } else {
                throw ServerException(message: "Server error")
            }
        }
    }

    /**
     *
     *
     * @param deviceId  (optional)
     * @param projectId  (optional)
     * @return void
     */
    func consumerStartNewSessionForDevice(deviceId: String? = nil, projectId: String? = nil) throws {
        var localVariableQuery: [String: [String]] = [:]
        if let deviceId = deviceId {
            localVariableQuery["deviceId"] = [deviceId]
        }
        if let projectId = projectId {
            localVariableQuery["projectId"] = [projectId]
        }
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/consumer/startNewSession",
            query: localVariableQuery
        )
        let response: ApiInfrastructureResponse<Any?> = request(
            requestConfig: localVariableConfig, responseType: Any?.self
        )

        switch response.responseType {
        case .success:
            return
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError<Any?>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any?>).message ?? "Server error")
        }
    }
}

struct ExampleResponse: Codable {
    let exampleField: String
}
