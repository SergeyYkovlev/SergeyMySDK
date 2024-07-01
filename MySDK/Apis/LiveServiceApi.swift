//
//  LiveServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class LiveServiceApi: ApiClient {
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param body
     * @return [DeviceInfo]
     */
    func liveServiceGetLiveDevices(body: LiveDevicesListRequest) throws -> [DeviceInfo] {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/live/list"
        )
        let response: ApiInfrastructureResponse<[DeviceInfo]> = request(requestConfig: localVariableConfig, body: localVariableBody, responseType: [DeviceInfo].self)

        switch response.responseType {
        case .success:
            return (response as! Success<[DeviceInfo]>).data!
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<[DeviceInfo]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[DeviceInfo]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param deviceID  (optional)
     * @param projectID  (optional)
     * @return void
     */
    func liveServiceSubscribeOnDevice(deviceID: String? = nil, projectID: String? = nil) throws {
        var localVariableQuery: [String: [String]] = [:]
        if let deviceID = deviceID {
            localVariableQuery["deviceID"] = [deviceID]
        }
        if let projectID = projectID {
            localVariableQuery["projectID"] = [projectID]
        }
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/live/events",
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
