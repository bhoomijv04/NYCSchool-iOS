//
//  HomeViewModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation

public final class SchoolDetailViewModel: ObservableObject {
    
    public enum RouteType {
        case callNumber
        case email
        case openMap
    }
    
    private(set) var schoolModel: HomeViewCellViewModel
    
    private let coordinator: any SwiftUIEnqueueCoordinator<SchoolDetailViewModel.RouteType>
    private let schoolService: SchoolServiceProtocol = SchoolService.shared
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<SchoolDetailViewModel.RouteType>, schoolModel: HomeViewCellViewModel) {
        self.coordinator = coordinator
        self.schoolModel = schoolModel
    }
}
