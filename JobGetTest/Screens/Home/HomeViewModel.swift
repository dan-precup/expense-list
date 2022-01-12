//
//  HomeViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation
import Combine

protocol HomeCoordinator: Coordinatable {
    func presentAddEntryForm(delegate: AddEntryDelegate?)
}
protocol HomeViewModel: LoadingNotifier, ViewLoadedListener {
    var transactions: CurrentValueSubject<[TransactionList], Never> { get }
    func didSelectCreateEntry()
}

final class HomeViewModelImpl: BaseViewModel, HomeViewModel {
    
    let transactions = CurrentValueSubject<[TransactionList], Never>([])
    private let coordinator: HomeCoordinator
    private let transactionService: TransactionService
    
    init(coordinator: HomeCoordinator, transactionService: TransactionService = ServiceRegistry.shared.transactionService) {
        self.coordinator = coordinator
        self.transactionService = transactionService
        super.init()
    }
    
    func didFinishLoading() {
        reloadData()
    }
    
    func didSelectCreateEntry() {
        coordinator.presentAddEntryForm(delegate: self)
    }
    
    private func reloadData() {
        isLoading.value = true
        var transDict = [String: TransactionList]()
        for transaction in transactionService.getTransactions() {
            let transactionDateString = transaction.date?.dayString ?? "Undefined"
            var list = transDict[transactionDateString] ?? TransactionList(date: transaction.date ?? Date(), transactions: [])
            list.transactions.append(transaction)
            transDict[transactionDateString] = list
        }
        transactions.value = transDict.values.sorted(by: { $0.date > $1.date })
        isLoading.value = false
    }
}

extension HomeViewModelImpl: AddEntryDelegate {
    func didCreateNewEntry() {
        reloadData()
    }
}
