//
//  SwiftUI.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation
import SwiftUI

public protocol SwiftUICoordinator: AnyObject {
    associatedtype CustomView: View

    var rootHostingController: UIHostingController<CustomView>? { get }
}

public protocol SwiftUIEnqueueCoordinator<EnqueueContextType>: SwiftUICoordinator {
    associatedtype EnqueueContextType
    /// Should be used when attemping a new navigation push/present
    /// - Parameter context: Could be an enum indicating the navigation type or just data in the case of single navigation.
    /// - Parameter animated: Indicates if navigation is going to be animated.
    /// - Parameter completion: Completion block which called after navigation ends.
    /// - returns: the `View` to present as a result of the enqueue (if any view needs presenting)
    @discardableResult func enqueueRoute(with context: EnqueueContextType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView?
}
