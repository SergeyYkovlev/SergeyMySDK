//
//  NetworkMonitor.swift
//  MySDK
//
//  Created by Creonit on 11.07.2024.
//

import Network
import Combine

@available(iOS 13.0, *)
class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private let isConnectedSubject = CurrentValueSubject<Bool, Never>(false)
    public var isConnectedPublisher: AnyPublisher<Bool, Never> {
        return isConnectedSubject.eraseToAnyPublisher()
    }
    public private(set) var isConnected: Bool = false {
        didSet {
            isConnectedSubject.send(isConnected)
        }
    }

    private init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
}
