//
//  SearchServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class SearchServiceApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param query  (optional)
     * @param projectId  (optional)
     * @return SearchResult
     */
    func searchServiceSearch(query: String? = nil, projectId: String? = nil) throws -> SearchResult {
        var localVariableQuery: [String: [String]] = [:]
        if let query = query {
            localVariableQuery["query"] = [query]
        }
        if let projectId = projectId {
            localVariableQuery["projectId"] = [projectId]
        }

        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/search",
            query: localVariableQuery
        )

        let response: ApiInfrastructureResponse<SearchResult> = request(
            requestConfig: localVariableConfig,
            responseType: SearchResult.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success<SearchResult>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<SearchResult>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<SearchResult>).message ?? "Server error")
        }
    }
}
