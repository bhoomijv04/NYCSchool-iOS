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
    
    @Published var searchString = ""
    @Published public private(set) var state: State = .noContent
    @Published private(set) var schools: [HomeViewCellViewModel] = [HomeViewCellViewModel]()
    
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
            _ = try await schoolService.fetchSchoolList()
            
        } catch {
            await MainActor.run {
                let  scores = schoolService.fetchSATScoreFromJSON()
                schools = schoolService.fetchSchoolListFromJSON().map { school in
                    let score = scores.filter { scoreValue in
                        return school.dbn == scoreValue.dbn
                    }
                    return HomeViewCellViewModel(data: school, score: score.first)
                }
            }
        }
    }

    func search() -> [HomeViewCellViewModel] {
        if !searchString.isEmpty {
            return schools.filter { $0.school.school_name.lowercased().contains(searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) }
        } else {
            return schools
        }
    }
}





