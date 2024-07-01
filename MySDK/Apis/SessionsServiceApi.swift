//
//  SessionsServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation


class SessionsServiceApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param body
     * @return PageListOfSessionSummary
     */
    func sessionsServiceGetSessionsByFilter(body: SessionFilter) throws -> PageListOfSessionSummary {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/session/list/filtered"
        )
        let response: ApiInfrastructureResponse<PageListOfSessionSummary> = request(
            requestConfig: localVariableConfig,
            body: localVariableBody,
            responseType: PageListOfSessionSummary.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success<PageListOfSessionSummary>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<PageListOfSessionSummary>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<PageListOfSessionSummary>).message ?? "Server error")
        }
    }
}
