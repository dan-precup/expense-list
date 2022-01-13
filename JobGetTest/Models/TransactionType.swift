//
//  TransactionType.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import Foundation

enum TransactionType: Int, CaseIterable {
    case expense
    case income
    
    /// The human readable title
    var title: String {
        switch self {
        case .expense: return "Expense"
        case .income: return "Income"
        }
    }
}
