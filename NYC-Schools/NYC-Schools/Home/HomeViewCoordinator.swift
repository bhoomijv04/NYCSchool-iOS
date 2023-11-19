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
    
    func instantiate() -> UIViewController {
        let viewModel = HomeViewModel()
        let rootView = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: rootView)
        self.rootHostingController = viewController
        return viewController
    }
    
    func enqueueRoute(with context: HomeViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        switch context {
            
        case .goToDetailsView:
            rootHostingController?.navigationController?.popViewController(animated: true)
        }
        return nil
    }
}
