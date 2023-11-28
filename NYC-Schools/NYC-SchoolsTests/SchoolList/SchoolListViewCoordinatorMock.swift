//
//  SchoolListCoordinatorMock.swift
//  NYC-SchoolsTests
//
//  Created by Bhoomi Vadgama on 28/11/23.
//

import Foundation
@testable import NYC_Schools
import SwiftUI


final class SchoolListViewCoordinatorMock: SwiftUIEnqueueCoordinator {
    
    public typealias EnqueueContextType = SchoolListViewModel.RouteType
    
    public init() {}
    
    public var nextRoute: SchoolListViewModel.RouteType?
    public weak var rootHostingController: UIHostingController<AnyView>?
    
    func instantiateView() -> UIViewController {
        return UIViewController()
    }
    
    public func enqueueRoute(with context: SchoolListViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        nextRoute = context
        return nil
    }
}
