//
//  AddEntryContracts.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Combine
import Foundation

protocol AddEntryDelegate: AnyObject {
    func didCreateNewEntry()
}

protocol AddEntryViewModel: LoadingNotifier, JGDropDownDelegate, ViewLoadedListener {
    var transactionTypeOptions: [String] { get }
    var ctaEnabled: CurrentValueSubject<Bool, Never> { get }
    var transactionAmount: CurrentValueSubject<Double, Never> { get }

    func didChangeStepperAmount(to: Double)
    func didChangeAmount(to: String?)
    func didChangeDescription(to: String?)
    func didSelectCreateEntity()
    func didSelectClose()
}
