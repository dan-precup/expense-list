//
//  HomeViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation
import Combine

protocol HomeCoordinator: Coordinatable {
    func presentAddEntryForm()
}
protocol HomeViewModel: LoadingNotifier, ViewLoadedListener {
    var transactions: CurrentValueSubject<[TransactionList], Never> { get }
    func didSelectCreateEntry()
}

final class HomeViewModelImpl: BaseViewModel, HomeViewModel {
    let transactions = CurrentValueSubject<[TransactionList], Never>([])
    private let coordinator: HomeCoordinator
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        super.init()
    }
    
    func didFinishLoading() {
        
    }
    
    func didSelectCreateEntry() {
        coordinator.presentAddEntryForm()
    }
}

