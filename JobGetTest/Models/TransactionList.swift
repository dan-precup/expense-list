//
//  TransactionList.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

struct TransactionList {
    let date: Date
    var transactions: [Transaction]
    var dayTotal: Double {
        transactions.reduce(0, { $0 + $1.signedAmount })
    }
}
