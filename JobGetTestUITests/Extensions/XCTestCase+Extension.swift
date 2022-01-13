//
//  XCTestCase+Extension.swift
//  JobGetTestUITests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func app(flags: [TransactionMockFlag] = []) -> XCUIApplication {
        XCUIApplication.new(arguments: flags.map({$0.rawValue}))
    }

}
