//
//  XCUITest+Extension.swift
//  NutmegUITests
//
//  Created by Dan Precup on 23/12/2019.
//  Copyright © 2019 Nutmeg. All rights reserved.
//

import XCTest

extension XCTestCase {
    func addDebugDescriptionAttachment(_ app: XCUIApplication, file: StaticString = #file, preserveIfSuccessfull: Bool = false) {
         //saves debug description at the time of failed test
         let stringAttachment = XCTAttachment(string: app.debugDescription)
         stringAttachment.lifetime = !preserveIfSuccessfull ? .deleteOnSuccess : .keepAlways
        stringAttachment.name = file.description + ".txt"
        add(stringAttachment)
     }

    func addScreenshot(_ app: XCUIApplication, preserveIfSuccessfull: Bool) {
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = !preserveIfSuccessfull ? .deleteOnSuccess : .keepAlways
        add(attachment)
    }

}
