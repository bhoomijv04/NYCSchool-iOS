//
//  HomeViewModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation

public final class HomeViewModel: ObservableObject {
    
    public enum RouteType {
        case goToDetailsView(viewModel:NYCSchool)
    }
    
    public enum State: Equatable {
        case noContent
        case success
        case error(_ message: String)
    }
    @Published public private(set) var state: State = .noContent
    @Published private(set) var schools: [HomeViewCellViewModel] = [HomeViewCellViewModel]()
    
    public let coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>
    private let schoolService: SchoolServiceProtocol
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>, service: any NetworkingServiceProtocol = NetworkingService()) {
        self.coordinator = coordinator
        self.schools = HomeViewCellViewModel.sampleData
        schoolService = SchoolService()
    }
    
    public func getNYCSchoolList() async {
        await MainActor.run {
            //animatedLoadingViewModel.animate.value = true
        }
        do {
            let school = try await schoolService.fetchSchoolList()
        } catch {
            await MainActor.run {
                schools = schoolService.fetchSchoolListFromJSON().map { school in
                    return HomeViewCellViewModel(data: school)
                }
            }
        }
    }
}





