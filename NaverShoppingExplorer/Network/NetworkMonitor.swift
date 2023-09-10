//
//  NetworkMonitor.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/11.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .cellular
    var networkStatusUpdater: ((Bool) -> Void)?
    
    enum ConnectionType {
        case wifi
        case cellular
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            if let isConnected = self?.isConnected {
                self?.networkStatusUpdater?(isConnected)
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else {
            path.usesInterfaceType(.cellular)
            connectionType = .cellular
        }
    }
}
