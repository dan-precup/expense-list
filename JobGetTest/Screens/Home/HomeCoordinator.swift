//
//  HomeCoordinator.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

final class HomeCoordinatorImpl: BaseCoordinator {
    
    /// Start the coordinator
    func start() {
        let viewModel = HomeViewModelImpl(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        setController(viewController)
    }
}

// MARK: - HomeCoordinator implementation
extension HomeCoordinatorImpl: HomeCoordinator {
    /// Present the add entry screen
    /// - Parameter delegate: The delegate that will be announced when the user finished adding the entity
    func presentAddEntryForm(delegate: AddEntryDelegate?) {
        let viewModel = AddEntryViewModelImpl(coordinator: self)
        viewModel.delegate = delegate
        let viewController = AddEntryViewController(viewModel: viewModel)
        present(viewController, presentationStyle: .overCurrentContext)
    }
}
