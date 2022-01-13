//
//  AddEntryViewModel.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

final class AddEntryViewModelImpl: BaseViewModel, AddEntryViewModel {
    var transactionTypeOptions: [String] = TransactionType.allCases.map({ $0.title })
    private let coordinator: Coordinatable
    
    weak var delegate: AddEntryDelegate?
    var transactionType: TransactionType = .expense
    let transactionDescription = CurrentValueSubject<String, Never>("")
    let transactionAmount = CurrentValueSubject<Double, Never>(0)
    let ctaEnabled = CurrentValueSubject<Bool, Never>(false)
    private let transactionService: TransactionService

    init(coordinator: Coordinatable,
         transactionService: TransactionService = ServiceRegistry.shared.transactionService) {
        self.coordinator = coordinator
        self.transactionService = transactionService
        super.init()
    }
    
    func didFinishLoading() {
        transactionDescription.combineLatest(transactionAmount)
            .sink(receiveValue: { [weak self] description, amount in
                self?.ctaEnabled.value = !description.isEmpty && amount != 0
            }).store(in: &bag)
    }
    
    func dropDown(_ dropdown: JGDropDown, didSelectOption atIndex: Int) {
        transactionType = TransactionType(rawValue: atIndex) ?? .expense
    }
    
    func didChangeAmount(to newAmount: String?) {
        guard let newAmount = newAmount else { return }
        transactionAmount.value = NumberFormatter.currencyDouble(from: newAmount)
    }
    
    func didChangeDescription(to newDescription: String?) {
        transactionDescription.value = newDescription ?? ""
    }
    
    func didChangeStepperAmount(to newAmount: Double) {
        transactionAmount.value = newAmount
    }
    
    func didSelectCreateEntity() {
        guard ctaEnabled.value else { return }
        transactionService.create(name: transactionDescription.value,
                                  amount: transactionAmount.value,
                                  type: transactionType)
        coordinator.dismiss(completion: { [weak self] in
            self?.delegate?.didCreateNewEntry()
        })
    }
    
    func didSelectClose() {
        coordinator.dismiss()
    }
}

