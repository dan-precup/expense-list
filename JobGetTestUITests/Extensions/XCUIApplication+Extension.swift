//
//  XCUIApplication+Extension.swift
//  JobGetTestUITests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest

//#MARK:- Helpers
extension XCUIApplication {
    static var ctaButtonIdentifier = "ctaButton"
    
    func launch(with arguments: [TransactionMockFlag]) -> XCUIApplication {
        launchArguments = ["testMode"] + arguments.map({$0.rawValue})
        launch()
        return self
    }
    
    static func launchNew(arguments: [String]) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["testMode"] + arguments
        app.launch()
        return app
    }
    
    static func new(arguments: [String]) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["testMode"] + arguments
        return app
    }
    //#MARK: Visuals
    @discardableResult
    func iSeeNavTitleIs(_ string: String, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(navigationBars.staticTexts[string].waitForExistence(timeout: .standardTimeout), file: file, line: line)
        return self
    }
    
    
    @discardableResult
    func checkValueInLabel(_ identifier: String, value: String, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(staticTexts[identifier].exists, file: file, line: line)
        XCTAssertEqual(staticTexts[identifier].label, value, file: file, line: line)
        return self
    }
    
    @discardableResult
    func progressBarExists(_ identifier: String = "progressView", timeout: Double = .standardTimeout, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(progressIndicators[identifier].waitForExistence(timeout: timeout),  "Could not find progressbar with identifier: \(identifier)", file: file, line: line)
        return self
    }
    
    @discardableResult
    func progressBarValue(_ identifier: String = "progressView", value: String, timeout: Double = .standardTimeout, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(progressIndicators[identifier].waitForExistence(timeout: timeout),  "Could not find progressbar with identifier: \(identifier)", file: file, line: line)
        XCTAssertEqual(progressIndicators[identifier].value as? String ?? "", value)
        return self
    }

    @discardableResult
    func iWaitAndSeeString(_ string: String, timeout: Double = .standardTimeout, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(staticTexts[string].waitForExistence(timeout: timeout), "Could not find string: \(string)", file: file, line: line)
        return self
    }

    @discardableResult
    func iWaitAndTapButton(_ identifier: String, timeout: Double = .standardTimeout, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(buttons[identifier].waitForExistence(timeout: timeout), "Cannot find button with idenfier \(identifier) ", file: file, line: line)
        buttons[identifier].tap()
        return self
    }

    @discardableResult
    func iSeeCTAButtonIsEnabled(file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(buttons[XCUIApplication.ctaButtonIdentifier].isEnabled, "CTA Button is not enabled", file: file, line: line)
        return self
    }

    @discardableResult
    func iSeeCTAButtonIsDisabled(file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertFalse(buttons[XCUIApplication.ctaButtonIdentifier].isEnabled, "CTA Button is enabled", file: file, line: line)
        return self
    }

    @discardableResult
    func buttonExists(_ identifier: String, timeout: TimeInterval = 0, file: StaticString = #file, line: UInt = #line) -> Self {
        let existance = timeout == 0 ? buttons[identifier].exists : buttons[identifier].waitForExistence(timeout: timeout)
        XCTAssertTrue(existance, "Cannot find button with identifier \(identifier)", file: file, line: line)
        return self
    }

    @discardableResult
    func stringExists(_ string: String, file: StaticString = #file, line: UInt = #line) -> Self {
        return stringsExist([string], file: file, line: line)
    }
    
    @discardableResult
    func stringExists(_ string: String, inTextField: String,  file: StaticString = #file, line: UInt = #line) -> Self {
        let textField = textFields[inTextField]
        XCTAssertTrue(textField.exists, "Could not find TextField with identifier: \(inTextField)", file: file, line: line)
        XCTAssertEqual(textField.value as! String, string, "Value in TextField with identifier: \(inTextField) in not \(string)",
            file: file,
            line: line)
        return self
    }

    @discardableResult
    func stringsExist(_ strings: [String], inElement: XCUIElementTypeQueryProvider? = nil, file: StaticString = #file, line: UInt = #line) -> Self {
        let element = inElement ?? self
        element.checkStringsExist(strings, file: file, line: line)
        return self
    }

    @discardableResult
    func stringExist(_ string: String, inElement: XCUIElementTypeQueryProvider? = nil, file: StaticString = #file, line: UInt = #line) -> Self {
        let element = inElement ?? self
        element.checkStringExists(string)
        return self
    }

    @discardableResult
    func iSeeOtherElements(withIdentifiers identifiers: [String],  file: StaticString = #file, line: UInt = #line) -> Self {
        identifiers.forEach {
            XCTAssertTrue(otherElements[$0].exists, "Cannot find Other Element with identifier: \($0)", file: file, line: line)
        }
        return self
    }

    @discardableResult
    func iSeeTextFieldValue(identifier: String, value: String, file: StaticString = #file, line: UInt = #line) -> Self {
        let textField = otherElements.textFields[identifier]
        XCTAssertTrue(textField.exists, "Cannot find Text Field with identifier: \(identifier)", file: file, line: line)
        XCTAssertEqual(textField.value as? String, value, "TextField with identifier: \(identifier) has wrong value", file: file, line: line)
        return self
    }

    @discardableResult
    func stringDoesNotExist(_ string: String, file: StaticString = #file, line: UInt = #line) -> Self {
        return stringsDontExist([string], file: file, line: line)
    }

    @discardableResult
    func stringsDontExist(_ strings: [String], inElement: XCUIElement? = nil, file: StaticString = #file, line: UInt = #line) -> Self {
        let element = inElement ?? self
        element.checkStringsDontExist(strings, file: file, line: line)
        return self
    }

    @discardableResult
    func tapOnTheCTAButton(file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(buttons[XCUIApplication.ctaButtonIdentifier].exists, file: file, line: line)
        buttons[XCUIApplication.ctaButtonIdentifier].tap()
        return self
    }

    @discardableResult
    func iType(_ text: String, inTextFieldWithIdentifier identifier: String, shouldClear: Bool = true, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(textFields[identifier].exists, file: file, line: line)
        textFields[identifier].tap()
        if shouldClear {
            textFields[identifier].clearAndEnterText(text: text)
        } else {
            textFields[identifier].typeText(text)
        }
       
        return self
    }

    @discardableResult
    func clearTextField(_ identifier: String, file: StaticString = #file, line: UInt = #line) -> Self {
        let textField = textFields[identifier]
        XCTAssertTrue(textField.exists, file: file, line: line)
        guard let stringValue = textField.value as? String else {
            XCTFail("Tried to clear text into a non string value")
            return self
        }

        textField.tap()
        let deleteString = stringValue.map { _ in "\u{8}" }.joined(separator: "")
        typeText(deleteString)
        return self
    }

    @discardableResult
    func tapOnButton(_ identifier: String, inElement: XCUIElementTypeQueryProvider? = nil, file: StaticString = #file, line: UInt = #line) -> Self {
        let element = inElement ?? self
        XCTAssertTrue(element.buttons[identifier].exists, "Could not find button with identifier: \(identifier)", file: file, line: line)
        element.buttons[identifier].tap()
        return self
    }

    @discardableResult
    func tapOnView(withIdentifier: String, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTAssertTrue(otherElements[withIdentifier].exists, "Could not find view with identifier: \(withIdentifier)", file: file, line: line)
        otherElements[withIdentifier].tap()
        return self
    }
    
    @discardableResult
    func enterCharacters(_ string: String, file: StaticString = #file, line: UInt = #line) -> Self {
        for char in string {
            keys[String(char)].tap()
        }
        return self
    }
}
