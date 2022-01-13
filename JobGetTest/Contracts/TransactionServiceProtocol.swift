//
//  TransactionService.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import Foundation

protocol TransactionService {
    func create(name: String, amount: Double, type: TransactionType)
    func getTransactions() -> [SingleTransaction]
    func deleteTransaction(_ transaction: SingleTransaction)
}
