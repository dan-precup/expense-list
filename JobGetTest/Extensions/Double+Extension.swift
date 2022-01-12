//
//  Double+Extension.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

extension Double {
    var asString: String {
        return NumberFormatter.decimalFormatter().string(from: NSNumber(value: self)) ?? ""
    }
    
    var asCurrency: String {
        let formatter = NumberFormatter.decimalFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
