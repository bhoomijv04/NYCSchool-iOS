//
//  HomeViewCoordinator.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation
import SwiftUI

final class SchoolListViewCoordinator: SwiftUIEnqueueCoordinator {
    
    typealias EnqueueContextType = SchoolListViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<SchoolListView>?
    
    // MARK: Intitate HomeView
    func instantiateView() -> UIViewController {
        let viewModel = SchoolListViewModel(coordinator: self)
        let rootView = SchoolListView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: rootView)
        self.rootHostingController = viewController
        return viewController
    }
    
    // MARK: Navigation route from HomeView
    func enqueueRoute(with context: SchoolListViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        switch context {
            
        case .goToDetailsView(let schoolModel):
            print(schoolModel)
            return AnyView(SchoolDetailViewCoordinator().instantiateView(school: schoolModel))
        }
    }
}
