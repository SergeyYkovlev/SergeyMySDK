//
//  ArtefactsServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import Foundation

class ArtefactsServiceApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param body
     * @return PageListOfArtefactDTO
     */
    func artefactsServiceArtefacts(body: ArtefactsListRequest) throws -> PageListOfArtefactDTO {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/artefacts"
        )
        let response: ApiInfrastructureResponse<PageListOfArtefactDTO> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: PageListOfArtefactDTO.self)
        
        switch response.responseType {
        case .success:
            return (response as! Success<PageListOfArtefactDTO>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<PageListOfArtefactDTO>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<PageListOfArtefactDTO>).message ?? "Server error")
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
     * @param ver  (optional)
     * @param environment  (optional)
     * @param flavor  (optional)
     * @param platform  (optional)
     * @param build  (optional)
     * @param artefactExt  (optional)
     * @return String
     */
    func artefactsServiceUpload(contentType: String? = nil, contentDisposition: String? = nil, headers: [Any]? = nil, length: Int? = nil, name: String? = nil, fileName: String? = nil, projectId: String? = nil, ver: String? = nil, environment: String? = nil, flavor: String? = nil, platform: String? = nil, build: Int? = nil, artefactExt: String? = nil) throws -> String {
        let localVariableBody: Any = [
            "ContentType": contentType ?? "",
            "ContentDisposition": contentDisposition ?? "",
            "Headers": headers ?? [],
            "Length": length ?? 0,
            "Name": name ?? "",
            "FileName": fileName ?? ""
        ]
        var localVariableQuery: [String: [String]] = [:]
        if let projectId = projectId { localVariableQuery["projectId"] = [projectId] }
        if let ver = ver { localVariableQuery["ver"] = [ver] }
        if let environment = environment { localVariableQuery["environment"] = [environment] }
        if let flavor = flavor { localVariableQuery["flavor"] = [flavor] }
        if let platform = platform { localVariableQuery["platform"] = [platform] }
        if let build = build { localVariableQuery["build"] = [String(build)] }
        if let artefactExt = artefactExt { localVariableQuery["artefactExt"] = [artefactExt] }

        var localVariableHeaders: [String: String] = ["Content-Type": "multipart/form-data"]
        localVariableHeaders["Accept"] = "application/json"

        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/artefacts/create",
            headers: localVariableHeaders,
            query: localVariableQuery
        )

        let response: ApiInfrastructureResponse<String> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: String.self)

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
