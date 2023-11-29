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
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
