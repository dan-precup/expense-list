//
//  HomeViewModelTests.swift
//  JobGetTestTests
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import XCTest


class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModelImpl?
    private let transactionService = TransactionServiceMock.shared
    private let coordinator = MockHomeCoordinator()
    override func setUp() {
        super.setUp()
        sut = HomeViewModelImpl(coordinator: coordinator, transactionService: transactionService)
        transactionService.clear()
        sut?.didFinishLoading()
        
    }

    func testSelectCreateEntryCallsCoordinator() {
        sut?.didSelectCreateEntry()
        XCTAssertTrue(coordinator.addViewWasPresented)
    }

    func testCorrectIncomeStat() {
        transactionService.transactions = [
            TransactionServiceMock.makeTransaction(amount: 10, transactionType: .income),
            TransactionServiceMock.makeTransaction(amount: 10, transactionType: .income)
        ]
        
        sut?.didSelectRefreshData()
        XCTAssertEqual(sut?.incomes, 20)
    }
    
    func testCorrectExpensesStat() {
        transactionService.transactions = [
            TransactionServiceMock.makeTransaction(amount: 10, transactionType: .expense),
            TransactionServiceMock.makeTransaction(amount: 10, transactionType: .expense)
        ]
        
        sut?.didSelectRefreshData()
        XCTAssertEqual(sut?.expenses, -20)
    }
    
    func testCorrectTotalStat() {
        transactionService.transactions = [
            TransactionServiceMock.makeTransaction(amount: 100, transactionType: .income),
            TransactionServiceMock.makeTransaction(amount: 10, transactionType: .expense)
        ]
        
        sut?.didSelectRefreshData()
        XCTAssertEqual(sut?.total, 90)
    }
    
    func testDateGrouping() {
        let dayBeforeDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        transactionService.transactions = [
            TransactionServiceMock.makeTransaction(amount: 100, transactionType: .income),
            TransactionServiceMock.makeTransaction(amount: 10, date: dayBeforeDate, transactionType: .expense)
        ]
        
        sut?.didSelectRefreshData()
        XCTAssertEqual(sut?.transactions.value.count, 2)
    }
    
    func testAddEntryDelegateCallReloadsData() {
        XCTAssertEqual(sut?.total, 0)
        transactionService.transactions = [
            TransactionServiceMock.makeTransaction(amount: 100, transactionType: .income),
            TransactionServiceMock.makeTransaction(amount: 10, transactionType: .expense)
        ]
        
        sut?.didCreateNewEntry()
        XCTAssertEqual(sut?.total, 90)
    }
}
