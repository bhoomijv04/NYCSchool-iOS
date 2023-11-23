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
    
    public init(coordinator: any SwiftUIEnqueueCoordinator<HomeViewModel.RouteType>) {
        self.coordinator = coordinator
        self.schools = HomeViewCellViewModel.sampleData
    }
    /*
     public func getActivatedFactors() async {
     await MainActor.run {
     animatedLoadingViewModel.animate.value = true
     }
     
     do {
     let isPhase3Enabled = appContext.featuresChecker.isMFAPhase3Enabled
     let subscribedFactors = try await accountsServices.subscribedFactors(isMFAPhase3Enabled: isPhase3Enabled)
     let availableFactors = try await accountsServices.availableFactors(isMFAPhase3Enabled: isPhase3Enabled)
     
     await setupFactors(with: subscribedFactors, and: availableFactors)
     } catch {
     await MainActor.run {
     sections = []
     state = .error
     animatedLoadingViewModel.animate.value = false
     }
     }
     }
     
     @MainActor private func setupFactors(with subscribedFactors: [MFASecurityFactor], and availableFactors: [FactorBridge]) {
     defer {
     state = .success
     animatedLoadingViewModel.animate.value = false
     }
     sections.removeAll()
     // Add all available factors
     sections.append(contentsOf: TwoFactorSectionFactory.createSections(factors: availableFactors, localiser: self.localiser, isMFAPhase3SMSEnabled: appContext.featuresChecker.isMFAPhase3SMSEnabled))
     
     // First check if authentication app is on, if not, then don't populate the backup items
     guard subscribedFactors.contains(where: { $0.type == .authenticator && ($0.status == .active || $0.status == .success) }) else {
     sections.removeAll(where: { $0.type == .backupMethod })
     return
     }
     
     guard !subscribedFactors.isEmpty else {
     return
     }
     
     setUpToggles(with: subscribedFactors)
     }
     */
}





