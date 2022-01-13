//
//  SingleTransaction.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import Foundation
struct SingleTransaction {
    let name: String?
    let amount: Double
    let date: Date?
    let transactionType: TransactionType
    var transaction: Transaction?
    
    var isIncome: Bool { transactionType == .income }
    var signedAmount: Double {
        let incomeAdjustment: Double = isIncome ? 1: -1
        return amount * incomeAdjustment
    }
    
    static func from(transaction: Transaction) -> SingleTransaction {
        SingleTransaction(name: transaction.name,
                          amount: transaction.amount,
                          date: transaction.date,
                          transactionType: TransactionType(rawValue: transaction.trasactionType) ?? .expense,
                          transaction: transaction)
    }
}

// MARK: -  Equatable implementation
extension SingleTransaction: Equatable {
    static func == (rhs: SingleTransaction, lhs: SingleTransaction) -> Bool {
        rhs.amount == lhs.amount &&
        rhs.isIncome == lhs.isIncome &&
        rhs.name == lhs.name &&
        rhs.date?.formatted(format: "EEE MM yyyy HH:mm") == lhs.date?.formatted(format: "EEE MM yyyy HH:mm")
    }
}
