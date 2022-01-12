//
//  NumberFormatter+Extension.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation
extension NumberFormatter {
    static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        return formatter
    }()
    
    static func currencyDouble(from string: String) -> Double {
        NumberFormatter.decimalFormatter.number(from: string.replacingOccurrences(of: ",", with: ""))?.doubleValue ?? 0
    }
}
