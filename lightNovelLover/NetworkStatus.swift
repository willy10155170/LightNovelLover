//
//  NetworkStatus.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/26.
//

import Foundation
import Network

final class NetworkStatus: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published var isConnected = true
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
