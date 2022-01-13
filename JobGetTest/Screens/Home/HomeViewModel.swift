//
//  HomeViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

final class HomeViewModelImpl: BaseViewModel, HomeViewModel {
    private(set) var incomes: Double = 0
    private(set) var expenses: Double = 0
    private(set) var total: Double = 0
    let transactions = CurrentValueSubject<[TransactionList], Never>([])
    private let coordinator: HomeCoordinator
    private let transactionService: TransactionService
    
    init(coordinator: HomeCoordinator, transactionService: TransactionService = ServiceRegistry.shared.transactionService) {
        self.coordinator = coordinator
        self.transactionService = transactionService
        super.init()
    }
    
    /// React to the view finishing loading
    func didFinishLoading() {
        reloadData()
    }
    
    /// Start the create entity flow
    func didSelectCreateEntry() {
        coordinator.presentAddEntryForm(delegate: self)
    }
    
    /// Delete entry
    /// - Parameter transaction: The transaction to delete
    func deleteEntry(_ transaction: SingleTransaction) {
        isLoading.value = true
        transactionService.deleteTransaction(transaction)
        reloadData()
        isLoading.value = false
    }
    
    /// Refresh the data
    func didSelectRefreshData() {
        reloadData()
    }
    
    /// Reload data and prompt the ui to refresh
    private func reloadData() {
        isLoading.value = true
        var transDict = [String: TransactionList]()
        incomes = 0
        expenses = 0
        total = 0
        
        for transaction in transactionService.getTransactions() {
            let transactionDateString = transaction.date?.dayString ?? "Undefined"
            var list = transDict[transactionDateString] ?? TransactionList(date: transaction.date ?? Date(), transactions: [])
            list.transactions.append(transaction)
            transDict[transactionDateString] = list
            addToStatistics(transaction)
        }
        transactions.value = transDict.values.sorted(by: { $0.date > $1.date })
        isLoading.value = false
    }
    
    /// Hidrate statistics
    /// - Parameter transaction: The transaction
    private func addToStatistics(_ transaction: SingleTransaction) {
        let signedAmount = transaction.signedAmount
        if signedAmount > 0 {
            incomes += signedAmount
        } else {
            expenses += signedAmount
        }
        total += signedAmount
    }
}

// MARK: - AddEntryDelegate implementation
extension HomeViewModelImpl: AddEntryDelegate {
    func didCreateNewEntry() {
        reloadData()
    }
}
