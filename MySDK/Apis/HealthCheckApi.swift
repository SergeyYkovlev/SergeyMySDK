//
//  HealthCheckApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class HealthCheckApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @return String
     */
    func healthCheckIndex() throws -> String {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/healthcheck"
        )
        let response: ApiInfrastructureResponse<String> = request(requestConfig: localVariableConfig, responseType: String.self)

        switch response.responseType {
        case .success:
            return (response as! Success<String>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<String>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<String>).message ?? "Server error")
        }
    }
}
