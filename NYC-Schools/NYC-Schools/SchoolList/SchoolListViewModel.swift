//
//  HomeViewModel.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation

public final class SchoolListViewModel: ObservableObject {
    
    public enum RouteType {
        case goToDetailsView(viewModel: SchoolListCellViewModel)
        case callNumber(number: String)
        case sendEmail(email: String)
        case opnLink(link: String)
        case openMap(lat: Double, long: Double, name: String)
    }
    
    public enum HomeViewState: Equatable {
        case noContent
        case success
        case error
        case noInternet
    }
    
    @Published var searchString = ""
    @Published public private(set) var state: HomeViewState = .noContent
    @Published private(set) var schools: [SchoolListCellViewModel] = [SchoolListCellViewModel]()
    
    public let coordinator: any SwiftUIEnqueueCoordinator<SchoolListViewModel.RouteType>
    public let schoolService: SchoolServiceProtocol
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<SchoolListViewModel.RouteType>, schoolService: SchoolServiceProtocol) {
        self.coordinator = coordinator
        self.schoolService = schoolService
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

        }  catch NYCNetworkingError.noInternet {
            await MainActor.run {
                state = .noInternet
            }
            
        } catch {
            await MainActor.run {
                state = .error
            }
        }
    }
    
    // configure cell view model
    func schoolViewModel(school: NYCSchool, score: NYCSchoolScore?) -> SchoolListCellViewModel {
        return SchoolListCellViewModel(data: school, score: score, openURL: { [weak self] url in
            if let urlString = url {
                self?.coordinator.enqueueRoute(with: .opnLink(link: urlString), animated: true, completion: nil)
            }
        }, callPhone: { [weak self] number in
            if let phoneNumber = number {
                self?.coordinator.enqueueRoute(with: .callNumber(number: phoneNumber), animated: true, completion: nil)
            }
            
        }, openMap: { [weak self] school in
            if let latitude = school.latitude, let longitude = school.longitude {
                self?.coordinator.enqueueRoute(with: .openMap(lat: latitude, long: longitude, name: school.school_name), animated: true, completion: nil)
            }
            
        }, openEmail: { [weak self] email in
            if let email = email {
                self?.coordinator.enqueueRoute(with: .sendEmail(email: email), animated: true, completion: nil)
            }
        })
    }

    func search() -> [SchoolListCellViewModel] {
        if !searchString.isEmpty {
            return schools.filter { $0.school.school_name.lowercased().contains(searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) }
        } else {
            return schools
        }
    }
}





