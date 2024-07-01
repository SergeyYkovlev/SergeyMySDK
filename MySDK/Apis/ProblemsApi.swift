//
//  ProblemsApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class ProblemsApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param id
     * @return Problem
     */
    func problemsGetProblem(id: String) throws -> Problem {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/problems/\(id)"
        )
        let response: ApiInfrastructureResponse<Problem> = request(requestConfig: localVariableConfig, responseType: Problem.self)

        switch response.responseType {
        case .success:
            return (response as! Success<Problem>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<Problem>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Problem>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param body
     * @return FilterableListOfProblem
     */
    func problemsGetProblems(body: ProblemsRequest) throws -> FilterableListOfProblem {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/problems"
        )
        let response: ApiInfrastructureResponse<FilterableListOfProblem> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: FilterableListOfProblem.self)

        switch response.responseType {
        case .success:
            return (response as! Success<FilterableListOfProblem>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<FilterableListOfProblem>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<FilterableListOfProblem>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param id
     * @param status  (optional)
     * @return void
     */
    func problemsUpdateProblem(id: String, status: Bool? = nil) throws {
        var localVariableQuery: [String: [String]] = [:]
        if let status = status {
            localVariableQuery["status"] = [String(status)]
        }
        let localVariableConfig = RequestConfig(
            method: .PATCH,
            path: "/api/problems/\(id)",
            query: localVariableQuery
        )
        let response: ApiInfrastructureResponse<Any?> = request(requestConfig: localVariableConfig, responseType: Any?.self)

        switch response.responseType {
        case .success:
            return
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<Any?>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any?>).message ?? "Server error")
        }
    }
}
