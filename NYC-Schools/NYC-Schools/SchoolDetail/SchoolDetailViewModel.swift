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
    
    private(set) var schoolModel: SchoolListCellViewModel
    
    private let coordinator: any SwiftUIEnqueueCoordinator<SchoolDetailViewModel.RouteType>
    private let schoolService: SchoolServiceProtocol = SchoolService.shared
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<SchoolDetailViewModel.RouteType>, schoolModel: SchoolListCellViewModel) {
        self.coordinator = coordinator
        self.schoolModel = schoolModel
    }
    
    func getTotalScore() -> Int {
        var total = 0
        if let maths = schoolModel.score?.sat_math_avg_score {
            total = total + (Int(maths) ?? 0)
        }
        if let reading = schoolModel.score?.sat_critical_reading_avg_score {
            total = total + (Int(reading) ?? 0)
        }
        if let writing = schoolModel.score?.sat_writing_avg_score {
            total = total + (Int(writing) ?? 0)
        }
        return total
    }
}
