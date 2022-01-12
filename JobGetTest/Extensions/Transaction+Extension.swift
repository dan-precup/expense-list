//
//  Transaction+Extension.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

extension Transaction {
    
    var isIncome: Bool { trasactionType == Int32(TransactionType.income.rawValue) }
    var signedAmount: Double {
        let incomeAdjustment: Double = isIncome ? 1: -1
        return amount * incomeAdjustment
    }
}
