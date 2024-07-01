//
//  AuthApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class AuthApi: ApiClient {
    
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }
    
    /**
     *
     *
     * @param body
     * @return SuccessAuthResponse
     */
    func authAuthenticate(body: AuthenticateRequest) throws -> SuccessAuthResponse {
        let localVariableBody: Any? = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/auth/authenticate"
        )
        let response: ApiInfrastructureResponse<SuccessAuthResponse> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: SuccessAuthResponse.self
        )
        
        switch response.responseType {
        case .success:
            return (response as! Success<SuccessAuthResponse>).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError<SuccessAuthResponse>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<SuccessAuthResponse>).message ?? "Server error")
        }
    }
    
    /**
     *
     *
     * @param body
     * @return Bool
     */
    func authRegister(body: RegisterRequest) throws -> Bool {
        let localVariableBody: Any? = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/auth/register"
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
            throw ServerException(message: (response as! ServerError<Bool>).message ?? "Server error")
        }
    }
}
