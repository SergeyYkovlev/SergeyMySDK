//  LogScope.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import UIKit
import CommonCrypto
import Network
import Combine


public enum EnvironmentMode {
    case production
    case development
}

@available(iOS 13.0, *)
public class LogScope {
    public static let shared = LogScope()
    public init() {}

    var deviceId: UUID = UUID()
    private var isNetworkMonitorSetup = false
    public var projectId: String = ""
    var eventsCache = [RegisteredEvent]()
    private var cancellables = Set<AnyCancellable>()
    let queue = DispatchQueue(label: "com.logscope.queue", qos: .background)
    private let consumerApi = ConsumerApi(basePath: "https://logscope.ru")
    private var isSendingLogs = false

    var mode: EnvironmentMode = .production

    func start(context: UIViewController, projectId: String) {
        self.projectId = projectId
        deviceId = UUID() // This would be a placeholder for device-specific unique ID generation.

        catchErrors()
    }

    public func logInfo(identification: String, payload: [String: Any]? = nil) {
        let payloadString = convertToJSONString(payload) ?? "{}"
        addLog(RegisteredEvent(
            id: UUID().uuidString,
            timestamp: Int(Date().timeIntervalSince1970),
            identification: identification,
            kind: "Global",
            scope: "Information",
            severity: "Information",
            payload: payloadString,
            starred: false
        ))
    }

    public func logException(ex: Error) {
        logException(identification: ex.localizedDescription, stacktrace: Thread.callStackSymbols)
    }

    public func logException(identification: String?, stacktrace: [String]) {
        let payloadString = convertToJSONString(["stacktrace": stacktrace]) ?? "{}"
        addLog(RegisteredEvent(
            id: UUID().uuidString,
            timestamp: Int(Date().timeIntervalSince1970),
            identification: identification ?? "No message",
            kind: "Global",
            scope: "Information",
            severity: "Error",
            payload: payloadString,
            starred: false
        ))
    }

    public func rawLog(identification: String, scope: String, kind: String, severity: String, payload: [String: Any]? = nil) {
        let payloadString = convertToJSONString(payload) ?? "{}"
        addLog(RegisteredEvent(
            id: UUID().uuidString,
            timestamp: Int(Date().timeIntervalSince1970),
            identification: identification,
            kind: kind,
            scope: scope,
            severity: severity,
            payload: payloadString,
            starred: false
        ))
    }

    private func addLog(_ log: RegisteredEvent) {
        
        if !isNetworkMonitorSetup {
                    NetworkMonitor.shared.isConnectedPublisher
                        .sink { [weak self] isConnected in
                            if isConnected {
                                self?.sendStoredRequests()
                            }
                        }
                        .store(in: &cancellables)
                    
                    isNetworkMonitorSetup = true
                }
        
        queue.async {
            self.eventsCache.append(log)
            self.sendLogs()
        }
    }

    private func sendLogs() {
        queue.async { [weak self] in
            guard let self = self else { return }
            guard !self.isSendingLogs else { return }
            self.isSendingLogs = true

            while !self.eventsCache.isEmpty {
                let events = self.eventsCache
                self.eventsCache.removeAll()

                let batch = EventsBatch(
                    isLive: true,
                    os: 1,
                    iosInfo: IOSInfo(
                        isPhysical: TARGET_OS_SIMULATOR == 0,
                        localizedModel: UIDevice.current.localizedModel,
                        model: UIDevice.current.model,
                        systemVersion: UIDevice.current.systemVersion,
                        systemName: UIDevice.current.systemName,
                        utsName: self.getUtsName()),
                    identification: Identification(code: self.deviceId.uuidString, userIdentification: ""),
                    bundle: BundleInfo(version: "", build: "", branch: ""),
                    screenshotsBatch: ScreenshotsBatch(framesMaping: [], frames: []),
                    events: events,
                    projectID: self.projectId
                )

                do {
                    let success = try self.consumerApi.consumerConsumeEvents(body: batch)
                    if success {
                        NSLog("Logs sent successfully")
                    } else {
                        NSLog("Failed to send logs")
                    }
                } catch {
                    NSLog("Error sending logs: \(error)")
                }
                
                Thread.sleep(forTimeInterval: 1) // Delay for 1 second between requests
            }

            self.isSendingLogs = false
        }
    }

    private func getUtsName() -> UtsName {
        var uts = utsname()
        uname(&uts)
        let sysname = withUnsafePointer(to: &uts.sysname) { ptr in
            return String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        let nodename = withUnsafePointer(to: &uts.nodename) { ptr in
            return String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        let release = withUnsafePointer(to: &uts.release) { ptr in
            return String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        let version = withUnsafePointer(to: &uts.version) { ptr in
            return String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        let machine = withUnsafePointer(to: &uts.machine) { ptr in
            return String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        return UtsName(sysName: sysname, nodeName: nodename, releaseName: release, version: version, machine: machine)
    }

    private func catchErrors() {
        NSSetUncaughtExceptionHandler { exception in
            LogScope.handleUncaughtException(exception)
        }
    }

    private static func handleUncaughtException(_ exception: NSException) {
        LogScope.shared.logException(identification: exception.reason, stacktrace: exception.callStackSymbols)
    }
    
    func sendStoredRequests() {
        let storedRequests = RequestStorage().getStoredRequests()
        
        storedRequests.forEach { storedRequest in
            var request = URLRequest(url: storedRequest.url)
            request.httpMethod = storedRequest.method
            request.allHTTPHeaderFields = storedRequest.headers
            request.httpBody = storedRequest.body
            
            let task = URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    NSLog("Error sending stored request: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    NSLog("Stored request sent successfully")
                    RequestStorage().clearStoredRequests() // Clear stored requests if sent successfully
                } else {
                    NSLog("Failed to send stored request")
                }
            }
            
            task.resume()
        }
    }
}

private func convertToJSONString(_ dictionary: [String: Any]?) -> String? {
    guard let dictionary = dictionary else { return nil }
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return String(data: jsonData, encoding: .utf8)
    } catch {
        NSLog("Error converting dictionary to JSON string: \(error)")
        return nil
    }
}

//extension String {
//    func md5() -> String {
//        let length = Int(CC_MD5_DIGEST_LENGTH)
//        let messageData = self.data(using:.utf8)!
//        var digestData = Data(count: length)
//
//        _ = digestData.withUnsafeMutableBytes { digestBytes in
//            messageData.withUnsafeBytes { messageBytes in
//                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//            }
//        }
//
//        return digestData.map { String(format: "%02hhx", $0) }.joined()
//    }
//}
