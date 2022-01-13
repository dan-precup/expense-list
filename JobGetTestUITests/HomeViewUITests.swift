//
//  HomeViewUITests.swift
//  JobGetTestUITests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest

class HomeViewUITests: XCTestCase {
   private lazy var app = app()
    
    func testNavigationTitleCorrect() {
        app.launch(with: []).iSeeNavTitleIs("Transactions")
        
    }
    
    override func tearDown() {
          app.launchArguments.removeAll()
          addDebugDescriptionAttachment(app)
          super.tearDown()
      }
    
    func testStatsLabelExist() {
        app.launch(with: []).stringsExist([
            "expensesTitleLabel",
            "expensesValueLabel",
            "incomeTitleLabel",
            "incomeValueLabel",
            "balanceTitleLabel",
            "balanceValueLabel",
            "expensesRatioLabel",
        ])
        
            .progressBarValue(value: "0%")
            .checkValueInLabel("expensesValueLabel", value: "$0")
            .checkValueInLabel("incomeValueLabel", value: "$0")
            .checkValueInLabel("balanceValueLabel", value: "$0")
            .checkValueInLabel("expensesRatioLabel", value: "Clean slate - no expenses, no problems.")
            .iWaitAndSeeString("No transactions yet")
            .buttonExists("fabAddButton")
    }
    
    func testProgressValueExpense10Percent() {
        app.launch(with: [.income, .expense])
            .progressBarValue(value: "10%")
            .checkValueInLabel("expensesValueLabel", value: "$10")
            .checkValueInLabel("incomeValueLabel", value: "$100")
            .checkValueInLabel("balanceValueLabel", value: "$90")
            .checkValueInLabel("expensesRatioLabel", value: "Your expenses used up 10.00% of your income")
    }
    
    func testProgressValueExpense100Percent() {
        app.launch(with: [.expenseEqualsIncome])
            .progressBarValue(value: "100%")
            .checkValueInLabel("expensesValueLabel", value: "$100")
            .checkValueInLabel("incomeValueLabel", value: "$100")
            .checkValueInLabel("balanceValueLabel", value: "$0")
            .checkValueInLabel("expensesRatioLabel", value: "Your expenses used up 100.00% of your income")
    }
    
    func testProgressValueExpenseMoreThanIncome() {
        app.launch(with: [.expensesMoreThanIncome])
            .progressBarValue(value: "100%")
            .checkValueInLabel("expensesValueLabel", value: "$100")
            .checkValueInLabel("incomeValueLabel", value: "$10")
            .checkValueInLabel("balanceValueLabel", value: "-$90")
            .checkValueInLabel("expensesRatioLabel", value: "Your expenses are greater than your income.")
    }
    
    func testIncomeFirstLetter() {
        app.launch(with: [.income])
            .checkValueInLabel("transactionLetterLabel", value: "S")
    }
    
    func testIncomeDataCorrect() {
        app.launch(with: [.income])
            .checkValueInLabel("transactionNameLabel", value: "Salary")
            .checkValueInLabel("transactionAmountLabel", value: "$100")
    }
    
    func testExpenseFirstLetter() {
        app.launch(with: [.expense])
            .checkValueInLabel("transactionLetterLabel", value: "P")
    }
    
    func testExpenseDataCorrect() {
        app.launch(with: [.expense])
            .checkValueInLabel("transactionNameLabel", value: "Phone bill")
            .checkValueInLabel("transactionAmountLabel", value: "-$10")
    }
    
    func testThousandsSeparators() {
        app.launch(with: [.hugeIncome])
            .checkValueInLabel("transactionAmountLabel", value: "$100,000")
    }
    
    func testTappingCTAOpensAddForm() {
        app.launch(with: [])
            .iWaitAndTapButton("fabAddButton")
            .iWaitAndSeeString("Add transaction")
    }
}
