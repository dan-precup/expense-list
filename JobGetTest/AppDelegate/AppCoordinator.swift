//
//  AppCoordinator.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    // Start the service registry
    private let serviceRegistry = ServiceRegistry.shared
    /// Application window
    private let window: UIWindow?

    init(_ window: UIWindow?) {
        self.window = window
        super.init()
    }
    
    /// Start the coordinator
    func start() {
        window?.rootViewController = navigationController
        HomeCoordinatorImpl(navigationController).start()
        window?.makeKeyAndVisible()
    }
}
