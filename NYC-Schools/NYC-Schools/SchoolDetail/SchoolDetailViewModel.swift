//
//  HomeViewModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation

public final class SchoolDetailViewModel: ObservableObject {
    
    public enum RouteType {
        case goToDetailsView
    }
    
    private let coordinator: any SwiftUIEnqueueCoordinator<SchoolDetailViewModel.RouteType>
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<SchoolDetailViewModel.RouteType>) {
        self.coordinator = coordinator
    }
}





