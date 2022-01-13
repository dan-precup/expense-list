//
//  XCUIElementQuery+Extenision.swift
//  JobGetTestUITests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest

extension XCUIElementQuery {

    func containText(_ text: String) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
        return containing(predicate).count > 0
    }    
}
