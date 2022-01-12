//
//  HomeCoordinator.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

final class HomeCoordinatorImpl: BaseCoordinator, HomeCoordinator, AddEntryCoordinator {
    
    func start() {
        let viewModel = HomeViewModelImpl(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        setController(viewController)
    }
    
    func presentAddEntryForm() {
        let viewModel = AddEntryViewModelImpl(coordinator: self)
        let viewController = AddEntryViewController(viewModel: viewModel)
        present(viewController, presentationStyle: .overCurrentContext)
    }
}
