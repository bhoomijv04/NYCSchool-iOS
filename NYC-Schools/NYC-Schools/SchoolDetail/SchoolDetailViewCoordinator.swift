//
//  HomeViewCoordinator.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation
import SwiftUI

final class SchoolDetailViewCoordinator: SwiftUIEnqueueCoordinator {
    
    typealias EnqueueContextType = SchoolDetailViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<SchoolDetailView>?
    
    func instantiateView() -> SchoolDetailView {
        let viewModel = SchoolDetailViewModel(coordinator: self)
        let rootView = SchoolDetailView(viewModel: viewModel)
        return rootView
    }
    
    func enqueueRoute(with context: SchoolDetailViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        switch context {
            
        case .goToDetailsView:
            rootHostingController?.navigationController?.popViewController(animated: true)
        }
        return nil
    }
}
