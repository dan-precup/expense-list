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
    
    func presentAddEntryForm(delegate: AddEntryDelegate?) {
        let viewModel = AddEntryViewModelImpl(coordinator: self)
        viewModel.delegate = delegate
        let viewController = AddEntryViewController(viewModel: viewModel)
        present(viewController, presentationStyle: .overCurrentContext)
    }
}
