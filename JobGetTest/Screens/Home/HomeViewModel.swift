//
//  HomeViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation
import Combine

protocol HomeCoordinator: Coordinatable {}
protocol HomeViewModel: LoadingNotifier, ViewLoadedListener { }

final class HomeViewModelImpl: BaseViewModel, HomeViewModel {
    
    private let coordinator: HomeCoordinator
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        super.init()
    }
    
    func didFinishLoading() {
        
    }
}

