//
//  TestCasesServiceApi.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import Foundation


class TestCasesServiceApi: ApiClient {
    
     init(basePath: String = "http://localhost:8080") {
         super.init(baseUrl: basePath)
    }

    /**
     *
     *
     * @param testCaseRun  (optional)
     * @param sessionId  (optional)
     * @return void
     */
    func testCasesServiceAssignSession(testCaseRun: String? = nil, sessionId: String? = nil) throws {
        var queryParams: [String: [String]] = [:]
        if let testCaseRun = testCaseRun {
            queryParams["testCaseRun"] = [testCaseRun]
        }
        if let sessionId = sessionId {
            queryParams["sessionId"] = [sessionId]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/runs/assign-session",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<Any?> = request(requestConfig: requestConfig, responseType: Any?.self)

        switch response.responseType {
        case .success:
            return
        case .informational:
            fatalError("Informational response not handled")
        case .redirection:
            fatalError("Redirection response not handled")
        case .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param stepRun  (optional)
     * @param status  (optional)
     * @return void
     */
    func testCasesServiceChangeStateOfStepRun(stepRun: String? = nil, status: TestRunStatus? = nil) throws {
        var queryParams: [String: [String]] = [:]
        if let stepRun = stepRun {
            queryParams["stepRun"] = [stepRun]
        }
        if let status = status {
            queryParams["status"] = [String(status.rawValue)]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/runs/change-step-run-state",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<Any?> = request(requestConfig: requestConfig, responseType: Any?.self)

        switch response.responseType {
        case .success:
            return
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param projectId  (optional)
     * @param title  (optional)
     * @return TestSuit
     */
    func testCasesServiceCreateSuit(projectId: String? = nil, title: String? = nil) throws -> TestSuit {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        if let title = title {
            queryParams["title"] = [title]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/suits/create",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<TestSuit> = request(requestConfig: requestConfig, responseType: TestSuit.self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<TestSuit>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<TestSuit>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param body
     * @param projectId  (optional)
     * @param suitId  (optional)
     * @return TestSuit
     */
    func testCasesServiceCreateTest(body: TestBlueprint, projectId: String? = nil, suitId: String? = nil) throws -> TestSuit {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        if let suitId = suitId {
            queryParams["suitId"] = [suitId]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/tests/create",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<TestSuit> = request(requestConfig: requestConfig, body: body, responseType: TestSuit.self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<TestSuit>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<TestSuit>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param body
     * @return void
     */
    func testCasesServiceCreateTestRun(body: TestRunBlueprint) throws {
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/runs/create"
        )
        let response: ApiInfrastructureResponse<Any?> = request(requestConfig: requestConfig, body: body, responseType: Any?.self)

        switch response.responseType {
        case .success:
            return
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param runId  (optional)
     * @return [TestCasesRun]
     */
    func testCasesServiceDeleteRun(runId: String? = nil) throws -> [TestCasesRun] {
        var queryParams: [String: [String]] = [:]
        if let runId = runId {
            queryParams["runId"] = [runId]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/runs/delete",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<[TestCasesRun]> = request(requestConfig: requestConfig, responseType: [TestCasesRun].self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param projectId  (optional)
     * @param id  (optional)
     * @return void
     */
    func testCasesServiceDeleteSuit(projectId: String? = nil, id: String? = nil) throws {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        if let id = id {
            queryParams["id"] = [id]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/suits/delete",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<Any?> = request(requestConfig: requestConfig, responseType: Any?.self)

        switch response.responseType {
        case .success:
            return
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param projectId  (optional)
     * @return [TestCasesRun]
     */
    func testCasesServiceGetRunsList(projectId: String? = nil) throws -> [TestCasesRun] {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/runs/list",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<[TestCasesRun]> = request(requestConfig: requestConfig, responseType: [TestCasesRun].self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<[TestCasesRun]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[TestCasesRun]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param projectId  (optional)
     * @param testId  (optional)
     * @return TestCase
     */
    func testCasesServiceGetTest(projectId: String? = nil, testId: String? = nil) throws -> TestCase {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        if let testId = testId {
            queryParams["testId"] = [testId]
        }
        let requestConfig = RequestConfig(
            method: .GET,
            path: "/api/tests/tests/get",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<TestCase> = request(requestConfig: requestConfig, responseType: TestCase.self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param projectId  (optional)
     * @param groupId  (optional)
     * @return [TestCase]
     */
    func testCasesServiceGetTests(projectId: String? = nil, groupId: String? = nil) throws -> [TestCase] {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        if let groupId = groupId {
            queryParams["groupId"] = [groupId]
        }
        let requestConfig = RequestConfig(
            method: .GET,
            path: "/api/tests/tests/list",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<[TestCase]> = request(requestConfig: requestConfig, responseType: [TestCase].self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param projectId  (optional)
     * @return [TestSuit]
     */
    func testCasesServiceGetTestsTree(projectId: String? = nil) throws -> [TestSuit] {
        var queryParams: [String: [String]] = [:]
        if let projectId = projectId {
            queryParams["projectId"] = [projectId]
        }
        let requestConfig = RequestConfig(
            method: .GET,
            path: "/api/tests/tests/tree",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<[TestSuit]> = request(requestConfig: requestConfig, responseType: [TestSuit].self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<[TestSuit]>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<[TestSuit]>).message ?? "Server error")
        }
    }

    /**
     *
     *
     * @param runId  (optional)
     * @return TestCasesRun
     */
    func testCasesServiceRunById(runId: String? = nil) throws -> TestCasesRun {
        var queryParams: [String: [String]] = [:]
        if let runId = runId {
            queryParams["runId"] = [runId]
        }
        let requestConfig = RequestConfig(
            method: .POST,
            path: "/api/tests/runs/get",
            query: queryParams
        )
        let response: ApiInfrastructureResponse<TestCasesRun> = request(requestConfig: requestConfig, responseType: TestCasesRun.self)

        switch response.responseType {
        case .success:
            return response.data!
        case .informational, .redirection, .clientError:
            throw ClientException(message: (response as! ClientError<Any>).body as? String ?? "Client error")
        case .serverError:
            throw ServerException(message: (response as! ServerError<Any>).message ?? "Server error")
        }
    }
}
