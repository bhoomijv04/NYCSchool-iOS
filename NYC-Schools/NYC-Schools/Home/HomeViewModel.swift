//
//  HomeViewModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation

public final class HomeViewModel: ObservableObject {
    
    public enum RouteType {
        case goToDetailsView(viewModel: HomeViewCellViewModel)
    }
    
    public enum State: Equatable {
        case noContent
        case success
        case error(_ message: String)
    }
    @Published public private(set) var state: State = .noContent
    @Published private(set) var schools: [HomeViewCellViewModel] = [HomeViewCellViewModel]()
    @Published private(set) var schoolsScore: [SchoolDetaislScoreModel] = [SchoolDetaislScoreModel]()
    
    public let coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>
    private let schoolService: SchoolServiceProtocol = SchoolService.shared
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>) {
        self.coordinator = coordinator
    }
    
    public func getNYCSchoolList() async {
        await MainActor.run {
            //animatedLoadingViewModel.animate.value = true
        }
        do {
            let schools = try await schoolService.fetchSchoolList().map({ school in
                return HomeViewCellViewModel(data: school)
            })

        } catch {
            await MainActor.run {
                schools = schoolService.fetchSchoolListFromJSON().map { school in
                    return HomeViewCellViewModel(data: school)
                }
                schoolsScore = schoolService.fetchSATScoreFromJSON().map { score in
                    return SchoolDetaislScoreModel(data: score)
                }
            }
        }
    }
}





