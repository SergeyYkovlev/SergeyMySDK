//
//  LogScope.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation
import UIKit

public enum EnvironmentMode {
    case production
    case development
}

public class LogScope {
    static let shared = LogScope()
    private init() {}
    
    var deviceId: UUID = UUID()
    var projectId: String = ""
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
            if eventsCache.count > 100 { // Batch size limit
                sendLogs()
            }
        }
    }
    
    private func sendLogs() {
        guard !eventsCache.isEmpty else { return }
        
        let events = eventsCache
        eventsCache.removeAll()
        
        
        let batch = EventsBatch(
            isLive: true,
            bundle: BundleInfo(version: ""),
            events: events,
            projectID: projectId)
        
        guard let url = URL(string: "https://logscope.ru:443/api/logs") else { return }
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
