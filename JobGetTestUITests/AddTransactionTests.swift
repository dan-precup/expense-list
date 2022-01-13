//
//  AddTransactionTests.swift
//  JobGetTestUITests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest

class AddTransactionTests: XCTestCase {
    private lazy var app = app()
     
     func testNavigationTitleCorrect() {
         app.launch(with: []).iSeeNavTitleIs("Transactions")
         
     }
     
     override func tearDown() {
           app.launchArguments.removeAll()
           addDebugDescriptionAttachment(app)
           super.tearDown()
       }
    
    func testElementsExist() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .stringsExist([
             "Transaction description",
             "Amount"
            ])
            .buttonExists("closeButton")
            .buttonExists("ctaButton")
            .iSeeCTAButtonIsDisabled()
            .iSeeOtherElements(withIdentifiers: [
                "transactionDescription",
                "transactionAmount",
            "transactionType"
            ])
        
        XCTAssertTrue(app.steppers["amountStepper"].exists)
    }
    
    
    func testFillingRequirementsEnablesCTA() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iType("Some name", inTextFieldWithIdentifier: "transactionDescriptionTextField")
            .iType("20", inTextFieldWithIdentifier: "transactionAmountTextField")
            .iSeeCTAButtonIsEnabled()
    }
    
    func testAddingEntryRefreshesTransactionsList() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iType("Some name", inTextFieldWithIdentifier: "transactionDescriptionTextField")
            .iType("20", inTextFieldWithIdentifier: "transactionAmountTextField")
            .iSeeCTAButtonIsEnabled()
            .tapOnTheCTAButton()
            .iWaitAndSeeString("Some name")
            .checkValueInLabel("transactionNameLabel", value: "Some name")
            .checkValueInLabel("transactionAmountLabel", value: "-$20")
    }
    
    func testRemovingAmountMakesCTADisabled() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iType("Some name", inTextFieldWithIdentifier: "transactionDescriptionTextField")
            .iType("20", inTextFieldWithIdentifier: "transactionAmountTextField")
            .iSeeCTAButtonIsEnabled()
            .clearTextField("transactionAmountTextField")
            .iSeeCTAButtonIsDisabled()
    }
    
    
    func testRemovingDescriptionMakesCTADisabled() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iType("Some name", inTextFieldWithIdentifier: "transactionDescriptionTextField")
            .iType("20", inTextFieldWithIdentifier: "transactionAmountTextField")
            .iSeeCTAButtonIsEnabled()
            .clearTextField("transactionDescriptionTextField")
            .iSeeCTAButtonIsDisabled()
    }
    
    func testCloseButtonClosesModal() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iWaitAndTapButton("closeButton")
            .stringDoesNotExist("Add transaction")
    }
    
    func testStepperIncrementsTextfieldValue() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iType("20", inTextFieldWithIdentifier: "transactionAmountTextField")
            .iWaitAndTapButton("Increment")
            .iSeeTextFieldValue(identifier: "transactionAmountTextField", value: "21")
    }
    
    func testStepperDecrementsTextfieldValue() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .iType("20", inTextFieldWithIdentifier: "transactionAmountTextField")
            .iWaitAndTapButton("Decrement")
            .iSeeTextFieldValue(identifier: "transactionAmountTextField", value: "19")
    }
    
    
    func testMenuShowsBothValues() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
            .tapOnView(withIdentifier: "transactionType")
            .stringsExist(["Expenses", "Income"])
    }
}
