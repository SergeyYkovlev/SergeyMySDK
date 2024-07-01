//
//  FrontendRedirectorApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class FrontendRedirectorApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @return [UInt8]
     */
    func frontendRedirectorAASA() throws -> [UInt8] {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/apple-app-site-association"
        )
        let response: ApiInfrastructureResponse<[UInt8]> = request(requestConfig: localVariableConfig, responseType: [UInt8].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[UInt8]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[UInt8]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[UInt8]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @return [UInt8]
     */
    func frontendRedirectorAASAW() throws -> [UInt8] {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/.well-known/apple-app-site-association"
        )
        let response: ApiInfrastructureResponse<[UInt8]> = request(requestConfig: localVariableConfig, responseType: [UInt8].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[UInt8]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[UInt8]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[UInt8]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @return [UInt8]
     */
    func frontendRedirectorIndex() throws -> [UInt8] {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/"
        )
        let response: ApiInfrastructureResponse<[UInt8]> = request(requestConfig: localVariableConfig, responseType: [UInt8].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[UInt8]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[UInt8]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[UInt8]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param url (optional)
     * @return [UInt8]
     */
    func frontendRedirectorRedirect(url: String? = nil) throws -> [UInt8] {
        var localVariableQuery: [String: [String]] = [:]
        if let url = url {
            localVariableQuery["url"] = [url]
        }
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/redirect",
            query: localVariableQuery
        )
        let response: ApiInfrastructureResponse<[UInt8]> = request(requestConfig: localVariableConfig, responseType: [UInt8].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[UInt8]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[UInt8]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[UInt8]>).message ?? "Server error")
        }
    }
}
