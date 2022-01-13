//
//  TransactionServiceMock.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import Foundation

enum TransactionMockFlag: String, CaseIterable {
    case income
    case expense
    case incomeYesterday
    case expenseYesterday
    case expenseEqualsIncome
    case expensesMoreThanIncome
    case hugeIncome
    
    static func extractListFromStrings(_ strings: [String]) -> [TransactionMockFlag] {
        strings.compactMap({ TransactionMockFlag(rawValue: $0) })
    }
}

final class TransactionServiceMock: TransactionService {
    
    static let shared = TransactionServiceMock()
    var transactions: [SingleTransaction] = []
    
    func create(name: String, amount: Double, type: TransactionType) {
        transactions.append(SingleTransaction(name: name, amount: amount, date: Date(), transactionType: type))

    }
    
    func getTransactions() -> [SingleTransaction] {
        transactions

    }
    
    func deleteTransaction(_ transaction: SingleTransaction) {
        transactions.removeAll(where: {$0 == transaction})

    }
    
    func setMockFlags(_ flags: [TransactionMockFlag]) {
        var transactions = [SingleTransaction]()
        for flag in flags {
            switch flag {
            case .income:
                transactions.append(TransactionServiceMock.makeTransaction(name: "Salary", amount: 100, transactionType: .income))
            case .expense:
                transactions.append(TransactionServiceMock.makeTransaction(name: "Phone bill", amount: 10, transactionType: .expense))
            case .incomeYesterday:
                let dayBeforeDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                transactions.append(TransactionServiceMock.makeTransaction(name: "Yesterday's Salary", amount: 100, date: dayBeforeDate, transactionType: .income))
            case .expenseYesterday:
                let dayBeforeDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                transactions.append(TransactionServiceMock.makeTransaction(name: "Yesterday's Phone bill", amount: 10, date: dayBeforeDate, transactionType: .expense))
            case .expenseEqualsIncome:
                transactions.append(TransactionServiceMock.makeTransaction(name: "Salary", amount: 100, transactionType: .income))
                transactions.append(TransactionServiceMock.makeTransaction(name: "Phone bill", amount: 100, transactionType: .expense))
            case .expensesMoreThanIncome:
                transactions.append(TransactionServiceMock.makeTransaction(name: "Salary", amount: 10, transactionType: .income))
                transactions.append(TransactionServiceMock.makeTransaction(name: "Phone bill", amount: 100, transactionType: .expense))
            case .hugeIncome:
                transactions.append(TransactionServiceMock.makeTransaction(name: "Salary", amount: 100000, transactionType: .income))

            }
            self.transactions = transactions
        }
       
    }
    
    static func makeTransaction(name: String = "Transaction", amount: Double = 10, date: Date = Date(), transactionType: TransactionType = .expense) -> SingleTransaction {
        SingleTransaction(name: name, amount: amount, date: date, transactionType: transactionType, transaction: nil)
    }
    
    func clear() {
        transactions = []
    }
}
