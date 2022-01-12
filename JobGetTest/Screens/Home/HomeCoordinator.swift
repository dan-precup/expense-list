//
//  HomeCoordinator.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

final class HomeCoordinatorImpl: BaseCoordinator, HomeCoordinator {
    
    func start() {
        let viewModel = HomeViewModelImpl(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        setController(viewController)
    }
}
