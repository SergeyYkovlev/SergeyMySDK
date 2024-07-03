//
//  LogScope.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import UIKit
import CommonCrypto

public enum EnvironmentMode {
    case production
    case development
}

public class LogScope {
    public static let shared = LogScope()
    public init() {}
    
    var deviceId: UUID = UUID()
    public var projectId: String = ""
    var eventsCache = [RegisteredEvent]()
    let queue = DispatchQueue(label: "com.logscope.queue", qos: .background)
    
    var mode: EnvironmentMode = .production
    
    func start(context: UIViewController, projectId: String) {
        self.projectId = projectId
        deviceId = UUID() // This would be a placeholder for device-specific unique ID generation.
        
        catchErrors()
        
        // Start the background task for sending logs
        queue.async {
            self.sendLogs()
        }
    }
    
    public func logInfo(identification: String, payload: [String: Any]? = nil) {
        let payloadString = convertToJSONString(payload) ?? "{}"
        addLog(RegisteredEvent(
            id: UUID().uuidString,
            timestamp: Date().timeIntervalSince1970,
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
            timestamp: Date().timeIntervalSince1970,
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
            timestamp: Date().timeIntervalSince1970,
            identification: identification,
            kind: kind,
            scope: scope,
            severity: severity,
            payload: payloadString,
            starred: false
        ))
    }
    
    private func addLog(_ log: RegisteredEvent) {
        queue.sync {
            eventsCache.append(log)
            
            sendLogs()
            
        }
    }
    
    private func sendLogs() {
        
        let events = eventsCache
        eventsCache.removeAll()

        let device = UIDevice.current
        let identifierForVendor = device.identifierForVendor?.uuidString ?? "unknown_device_id"
        
        let deviceId = identifierForVendor.md5()
        
        let batch = EventsBatch(
            isLive: true,
            iosInfo: IOSInfo(isPhysical: TARGET_OS_SIMULATOR == 0,
                             localizedModel: UIDevice.current.localizedModel,
                             model: UIDevice.current.model,
                             systemVersion: UIDevice.current.systemVersion,
                             systemName: UIDevice.current.systemName,
                             utsName: getUtsName()),
            identification: Identification(code: deviceId),
            bundle: BundleInfo(version: ""),
            events: events,
            projectID: projectId)
        
        guard let url = URL(string: "https://logscope.ru:443") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(batch)
            request.httpBody = data
            
            let task = URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("Error sending logs: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Logs sent successfully")
                } else {
                    print("Failed to send logs")
                }
            }
            
            task.resume()
        } catch {
            print("Failed to encode log batch: \(error)")
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
}

private func convertToJSONString(_ dictionary: [String: Any]?) -> String? {
        guard let dictionary = dictionary else { return nil }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error converting dictionary to JSON string: \(error)")
            return nil
        }
    }

extension String {
    func md5() -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
