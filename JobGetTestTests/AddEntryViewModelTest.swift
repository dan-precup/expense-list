//
//  AddEntryViewModelTest.swift
//  JobGetTestTests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest
import Combine

class AddEntryViewModelTest: XCTestCase {
    private var sut: AddEntryViewModelImpl?
    private let transactionService = TransactionServiceMock()
    private let coordinator = MockCoordinatable()
    override func setUp() {
        super.setUp()
        sut = AddEntryViewModelImpl(coordinator: coordinator, transactionService: transactionService)
        sut?.didFinishLoading()
    }

    func testChangingTheDescriptionOnViewSetsTheDescriptionOnSut() {
        let value = "new description"
        sut?.didChangeDescription(to: value)
        XCTAssertEqual(sut!.transactionDescription.value, value)
    }
    
    func testChangingTheAmountOnViewSetsTheAmountOnSut() {
        let value:Double = 11
        sut?.didChangeAmount(to: "\(value)")
        XCTAssertEqual(sut!.transactionAmount.value, value)
    }
    
    
    func testChangingTheAmountOnViewStepperSetsTheAmountOnSut() {
        let value:Double = 11
        sut?.didChangeStepperAmount(to: value)
        XCTAssertEqual(sut!.transactionAmount.value, value)
    }
    
    func testSettingInvalidAmountMakesValueZero() {
        sut?.didChangeAmount(to: "not a number")
        XCTAssertEqual(sut!.transactionAmount.value, 0)
    }
    
    func testSelectingCloseCallsDismissOnCoordinator() {
        sut?.didSelectClose()
        XCTAssertTrue(coordinator.wasDismissed)
    }
    
    func testDisabledCTAFlagForNotSetAmount() {
        let result = expectValue(of: sut!.ctaEnabled.eraseToAnyPublisher(), equals: [false])
        sut?.didChangeDescription(to: "new description")
        wait(for: [result.expectation], timeout: 1)
    }
    
    func testDisabledCTAFlagForNotSetDescription() {
        let result = expectValue(of: sut!.ctaEnabled.eraseToAnyPublisher(), equals: [false])
        sut?.didChangeAmount(to: "11")
        wait(for: [result.expectation], timeout: 1)
    }
    
    func testEnabledCTAFlagIfDataSet() {
        let result = expectValue(of: sut!.ctaEnabled.eraseToAnyPublisher(), equals: [true])
        sut?.didChangeAmount(to: "11")
        sut?.didChangeDescription(to: "new description")
        wait(for: [result.expectation], timeout: 1)
    }
    
    func testDropDownSetsExpenseForZero() {
        sut!.dropDown(JGDropDown(options: [], title: ""), didSelectOption: 0)
        XCTAssertEqual(sut!.transactionType, TransactionType.expense)
    }
    
    func testDropDownSetsIncomeForOne() {
        sut!.dropDown(JGDropDown(options: [], title: ""), didSelectOption: 1)
        XCTAssertEqual(sut!.transactionType, TransactionType.income)
    }
    
    func testDropDownSetsExpenseForUnrecognized() {
        sut!.dropDown(JGDropDown(options: [], title: ""), didSelectOption: 21 )
        XCTAssertEqual(sut!.transactionType, TransactionType.expense)
    }
    
    func testCreatingEntityCallsService() {
        let result = expectValue(of: sut!.ctaEnabled.eraseToAnyPublisher(), equals: [true])
        sut?.didChangeAmount(to: "11")
        sut?.didChangeDescription(to: "new description")
        wait(for: [result.expectation], timeout: 1)
        sut?.didSelectCreateEntity()
        XCTAssertEqual(transactionService.transactions.first, SingleTransaction(name: "new description", amount: 11, date: Date(), transactionType: .expense, transaction: nil))
    }
    
    func testCallingCreateWithInvalidDataDoesNotCreateEntity() {
        transactionService.clear()
        sut?.didSelectCreateEntity()
        XCTAssertTrue(transactionService.getTransactions().isEmpty)
    }
}
