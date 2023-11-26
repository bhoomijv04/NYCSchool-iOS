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
    
    public enum HomeViewState: Equatable {
        case noContent
        case success
        case error
    }
    
    @Published var searchString = ""
    @Published public private(set) var state: HomeViewState = .noContent
    @Published private(set) var schools: [HomeViewCellViewModel] = [HomeViewCellViewModel]()
    
    public let coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>
    private let schoolService: SchoolServiceProtocol = SchoolService.shared
    private let commonVC: CommanUtilitiesProtocol = CommanUtilities.shared
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>) {
        self.coordinator = coordinator
    }
    
    public func getNYCSchoolList() async {
        await MainActor.run {
            state = .noContent
        }
        do {
            let scores = try await schoolService.fetchSchoolScore()
            let school = try await schoolService.fetchSchoolList().map { school in
                let score = scores.filter { scoreValue in
                    return school.dbn == scoreValue.dbn
                }
                return schoolViewModel(school: school, score: score.first)
            }
            await MainActor.run {
                self.schools = school
                state = .success
                
            }
        } catch {
             // In case of error it load data from JSON
             let  scores = schoolService.fetchSATScoreFromJSON()
             let schools = schoolService.fetchSchoolListFromJSON().map { school in
             let score = scores.filter { scoreValue in
             return school.dbn == scoreValue.dbn
             }
             return schoolViewModel(school: school, score: score.first)
             
             }
             await MainActor.run {
             self.schools = schools
             state = .success
             }
           /* await MainActor.run {
                state = .error
            }*/
        }
    }
    
    func schoolViewModel(school: NYCSchool, score: NYCSchoolScore?) -> HomeViewCellViewModel {
        return HomeViewCellViewModel(data: school, score: score, openURL: { [weak self] url in
            if let urlString = url {
                self?.commonVC.openURL(urlString: urlString)
            }
            
        }, callPhone: { [weak self] number in
            if let phoneNumber = number {
                self?.commonVC.callPhone(phone: phoneNumber)
            }
            
        }, openMap: { [weak self] school in
            self?.commonVC.openMap(school: school)
            
        }, openEmail: { [weak self] email in
            // self?.commonVC.sendEmail(root: self?.coordinator.rootHostingController?.navigationController)
        })
    }

    func search() -> [HomeViewCellViewModel] {
        if !searchString.isEmpty {
            return schools.filter { $0.school.school_name.lowercased().contains(searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) }
        } else {
            return schools
        }
    }
}





