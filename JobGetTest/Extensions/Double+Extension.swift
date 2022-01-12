//
//  Double+Extension.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

extension Double {
    var asString: String {
        return NumberFormatter.decimalFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
