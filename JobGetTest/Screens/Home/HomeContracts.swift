//
//  HomeContracts.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

protocol HomeCoordinator: Coordinatable {
    func presentAddEntryForm(delegate: AddEntryDelegate?)
}
protocol HomeViewModel: LoadingNotifier, ViewLoadedListener {
    var transactions: CurrentValueSubject<[TransactionList], Never> { get }
    var incomes: Double { get }
    var expenses: Double { get }
    var total: Double { get }
    func didSelectCreateEntry()
    func deleteEntry(_ transaction: SingleTransaction)
    func didSelectRefreshData()
}
