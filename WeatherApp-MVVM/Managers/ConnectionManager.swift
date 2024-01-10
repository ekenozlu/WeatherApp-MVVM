//
//  ConnectionManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation
import Network

final class ConnectionManager {
    //- MARK: Singleton Object
    public static let shared = ConnectionManager()
    
    //- MARK: Variables
    private let monitor = NWPathMonitor()
    private var isConnected: Bool = false
    
    //- MARK: Initializer, Deinitializer
    private init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    public func configure() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    private func stopMonitoring() {
        monitor.cancel()
    }
    
    ///This function controls the network connection.
    ///
    ///> Returns:
    ///>Boolean for the connection status. Returns true if the device connected.
    func isDeviceConnectedToNetwork() -> Bool {
        return isConnected
    }
}
