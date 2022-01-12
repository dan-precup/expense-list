//
//  AddEntryViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

protocol AddEntryCoordinator: Coordinatable {}
protocol AddEntryViewModel: LoadingNotifier, JGDropDownDelegate, ViewLoadedListener {
    var transactionTypeOptions: [String] { get }
    var ctaEnabled: CurrentValueSubject<Bool, Never> { get }
    func didChangeAmount(to: String?)
    func didChangeDescription(to: String?)
}

enum TransactionType: Int, CaseIterable {
    case expense
    case income
    
    var title: String {
        switch self {
        case .expense: return "Expense"
        case .income: return "Income"
        }
    }
}

final class AddEntryViewModelImpl: BaseViewModel, AddEntryViewModel {
    var transactionTypeOptions: [String] = TransactionType.allCases.map({ $0.title })
    private let coordinator: AddEntryCoordinator
    
    var transactionType: TransactionType = .expense
    var transactionDescription = CurrentValueSubject<String, Never>("")
    var transactionAmount = CurrentValueSubject<Double, Never>(0)
    let ctaEnabled = CurrentValueSubject<Bool, Never>(false)
    init(coordinator: AddEntryCoordinator) {
        self.coordinator = coordinator
        super.init()
    }
    
    func didFinishLoading() {
        transactionDescription.combineLatest(transactionAmount)
            .sink(receiveValue: { [weak self] description, amount in
                print("PLM", !description.isEmpty && amount != 0, description, amount)
                self?.ctaEnabled.value = !description.isEmpty && amount != 0
            }).store(in: &bag)
    }
    
    func dropDown(_ dropdown: JGDropDown, didSelectOption atIndex: Int) {
        transactionType = TransactionType(rawValue: atIndex) ?? .expense
    }
    
    func didChangeAmount(to newAmount: String?) {
        guard let newAmount = newAmount else { return }
        transactionAmount.value = Double(newAmount) ?? 0
    }
    
    func didChangeDescription(to newDescription: String?) {
        transactionDescription.value = newDescription ?? ""
    }
}

