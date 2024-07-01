//
//  DevicesServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

class DevicesServiceApi: ApiClient {
    
    init(basePath: String = "http://localhost:8080") {
        super.init(baseUrl: basePath)
    }
    
    /**
     *
     *
     * @param body
     * @return FilterableListOfAssociatedAccountSummary
     */
    
    
    func devicesServiceGetAccountsByFilter(body: AccountsRequest) throws -> FilterableListOfAssociatedAccountSummary {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/db/accounts/filtered"
        )
        let response: ApiInfrastructureResponse<FilterableListOfAssociatedAccountSummary> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: FilterableListOfAssociatedAccountSummary.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError).message ?? "Server error")
        }
    }
    
    /**
     *
     *
     * @param id  (optional)
     * @param projectId  (optional)
     * @return DeviceSummary
     */
    func devicesServiceGetDeviceSummaryByCode(id: String? = nil, projectId: String? = nil) throws -> DeviceSummary {
        var localVariableQuery: MultiValueMap = [:]
        if let id = id {
            localVariableQuery["id"] = [id]
        }
        if let projectId = projectId {
            localVariableQuery["projectId"] = [projectId]
        }
        let localVariableConfig = RequestConfig(
            method: .GET,
            path: "/api/db/device/exact",
            query: localVariableQuery
        )
        let response: ApiInfrastructureResponse<DeviceSummary> = request(
            requestConfig: localVariableConfig, responseType: DeviceSummary.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError).message ?? "Server error")
        }
    }
    
    /**
     *
     *
     * @param body
     * @return FilterableListOfDeviceSummary
     */
    func devicesServiceGetDevicesByFilter(body: DevicesRequest) throws -> FilterableListOfDeviceSummary {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/db/devices/filtered"
        )
        let response: ApiInfrastructureResponse<FilterableListOfDeviceSummary> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: FilterableListOfDeviceSummary.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError).message ?? "Server error")
        }
    }
    
    /**
     *
     *
     * @param body
     * @return FilterableListOfEventSummary
     */
    func devicesServiceGetEventsByFilter(body: EventsRequest) throws -> FilterableListOfEventSummary {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/db/all_events/filtered"
        )
        let response: ApiInfrastructureResponse<FilterableListOfEventSummary> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: FilterableListOfEventSummary.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError).message ?? "Server error")
        }
    }
    
    /**
     *
     *
     * @param body
     * @return LiveDeviceUpdate
     */
    func devicesServiceGetEventsBySession(body: SessionEventsRequest) throws -> LiveDeviceUpdate {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/db/events"
        )
        let response: ApiInfrastructureResponse<LiveDeviceUpdate> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: LiveDeviceUpdate.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError).message ?? "Server error")
        }
    }
    
    /**
     *
     *
     * @param body
     * @return FilterableListOfSessionSummary
     */
    func devicesServiceGetSessionsByFilter(body: SessionsRequest) throws -> FilterableListOfSessionSummary {
        let localVariableBody: Any = body
        let localVariableConfig = RequestConfig(
            method: .POST,
            path: "/api/db/sessions/filtered"
        )
        let response: ApiInfrastructureResponse<FilterableListOfSessionSummary> = request(
            requestConfig: localVariableConfig, body: localVariableBody, responseType: FilterableListOfSessionSummary.self
        )

        switch response.responseType {
        case .success:
            return (response as! Success).data!
        case .informational:
            throw NSError(domain: "Informational response", code: 100, userInfo: nil)
        case .redirection:
            throw NSError(domain: "Redirection response", code: 300, userInfo: nil)
        case .clientError:
            throw ClientException(message: (response as! ClientError).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError).message ?? "Server error")
        }
    }
}
