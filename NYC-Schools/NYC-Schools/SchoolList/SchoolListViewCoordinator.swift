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
    private let commonVC: CommanUtilitiesProtocol = NYCCommomUtility.shared
    
    // MARK: Intitate SchoolListView
    func instantiateView() -> UIViewController {
        let viewModel = SchoolListViewModel(coordinator: self, schoolService:  NYCSchoolService.shared)
        let rootView = SchoolListView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: rootView)
        self.rootHostingController = viewController
        return viewController
    }
    
    // MARK: Navigation route from SchoolListView
    func enqueueRoute(with context: SchoolListViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        switch context {
            
        case .goToDetailsView(let schoolModel):
            print(schoolModel)
            return AnyView(SchoolDetailViewCoordinator().instantiateView(school: schoolModel))

        case .callNumber(let phoneNumber):
            self.commonVC.callPhone(phone: phoneNumber)

        case .sendEmail(let email):
            self.commonVC.sendEmail(recipient:email, root: self.rootHostingController)

        case .opnLink(let link):
            self.commonVC.openURL(urlString: link)

        case .openMap(let lat, let long, let name):
            self.commonVC.openMap(lat: lat, long: long, name: name)
        }
        return nil
    }
}
