//
//  XCUIElementTypeQueryProvider+Extension.swift
//  JobGetTestUITests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest

extension XCUIElementTypeQueryProvider {

    func checkStringsExist(_ strings: [String], file: StaticString = #file, line: UInt = #line) {
        strings.forEach{ XCTAssertTrue(checkStringExists($0), "Cannot find static text: \($0)", file: file, line: line) }
    }

    func checkStringsDontExist(_ strings: [String], file: StaticString = #file, line: UInt = #line) {
        strings.forEach{ XCTAssertFalse(checkStringExists($0), "Static text: \($0) still exists", file: file, line: line) }
    }

    @discardableResult
    func checkStringExists(_ string: String) -> Bool {
        if string.count > 128 {
           return checkStringIsPresent(string)
        }

        return staticTexts[string].exists
    }

    func checkStringIsPresent(_ string: String) -> Bool {
        let predicate = NSPredicate(format: "label LIKE %@", string)
        let label = staticTexts.element(matching: predicate)
        return label.exists
    }
}
