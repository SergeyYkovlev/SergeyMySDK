//
//  ProjectsServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation


class ProjectsServiceApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param body
     * @return ProjectInfo
     */
    func projectsServiceCreateProject(body: String) throws -> ProjectInfo {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/project/create"
        )
        let response: ApiInfrastructureResponse<ProjectInfo> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: ProjectInfo.self)

        switch response.responseType {
        case .success:
            return (response as! Success<ProjectInfo>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<ProjectInfo>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<ProjectInfo>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param id
     * @return ProjectInfo
     */
    func projectsServiceGetById(id: String) throws -> ProjectInfo {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/project/\(id)"
        )
        let response: ApiInfrastructureResponse<ProjectInfo> = request(requestConfig: localVariableConfig, responseType: ProjectInfo.self)

        switch response.responseType {
        case .success:
            return (response as! Success<ProjectInfo>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<ProjectInfo>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<ProjectInfo>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param body
     * @return [ProjectUserSummary]
     */
    func projectsServiceGetProjectUsers(body: GetProjectUsersRequest) throws -> [ProjectUserSummary] {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/project/users"
        )
        let response: ApiInfrastructureResponse<[ProjectUserSummary]> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: [ProjectUserSummary].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[ProjectUserSummary]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[ProjectUserSummary]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[ProjectUserSummary]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @return [ProjectInfo]
     */
    func projectsServiceGetProjectsList() throws -> [ProjectInfo] {
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/project/all"
        )
        let response: ApiInfrastructureResponse<[ProjectInfo]> = request(requestConfig: localVariableConfig, responseType: [ProjectInfo].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[ProjectInfo]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[ProjectInfo]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[ProjectInfo]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param body
     * @return Bool
     */
    func projectsServiceInviteUserToProject(body: UserInviteRequest) throws -> Bool {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/project/invite"
        )
        let response: ApiInfrastructureResponse<Bool> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: Bool.self)

        switch response.responseType {
        case .success:
            return (response as! Success<Bool>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<Bool>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Bool>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param contentType  (optional)
     * @param contentDisposition  (optional)
     * @param headers  (optional)
     * @param length  (optional)
     * @param name  (optional)
     * @param fileName  (optional)
     * @param projectId  (optional)
     * @return void
     */
    func projectsServiceUpdateProjectPic(contentType: String? = nil, contentDisposition: String? = nil, headers: [Any]? = nil, length: Int? = nil, name: String? = nil, fileName: String? = nil, projectId: String? = nil) throws {
        let localVariableBody: Any = ["ContentType": contentType, "ContentDisposition" : contentDisposition, "Headers": headers, "Length": length, "Name": name, "FileName": fileName]
        var localVariableQuery: [String: [String]] = [:]
        if let projectId = projectId {
            localVariableQuery["projectId"] = [projectId]
        }
        var localVariableHeaders: [String: String] = ["Content-Type": "multipart/form-data"]

        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/project/picture",
            headers: localVariableHeaders, 
            query: localVariableQuery
        )
        let response: ApiInfrastructureResponse<Any?> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: Any?.self)

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
