//
//  NYCNetworkMonitor.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 28/11/23.
//

import Foundation
import Network
import SwiftUI

class NYCNetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            switch path.status {
            case .satisfied:
                // Networking connection restored
                self.isConnected = true
            default:
                // There's no connection available
                self.isConnected = false
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
