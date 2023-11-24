//
//  HomeViewCoordinator.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation
import SwiftUI

final class HomeViewCoordinator: SwiftUIEnqueueCoordinator {
    
    typealias EnqueueContextType = HomeViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<HomeView>?
    
    // MARK: Intitate HomeView
    func instantiateView() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: self)
        let rootView = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: rootView)
        self.rootHostingController = viewController
        return viewController
    }
    
    // MARK: Navigation route from HomeView
    func enqueueRoute(with context: HomeViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        switch context {
            
        case .goToDetailsView(let schoolModel):
            print(schoolModel)
            return AnyView(SchoolDetailViewCoordinator().instantiateView(school: schoolModel))
        }
    }
}
