//
//  ServiceRegistry.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

final class ServiceRegistry {
    
    /// Singleton instance
    static let shared = ServiceRegistry()
    private init() {}
    
    /// The local persistence layer
    let localStorage: LocalStorageService = CoreDataStorage()
    
    /// Transactions service
    lazy var transactionService: TransactionService =  {
        if ProcessInfo.processInfo.arguments.contains("testMode") {
            let service = TransactionServiceMock.shared
            service.setMockFlags(TransactionMockFlag.extractListFromStrings(ProcessInfo.processInfo.arguments))
            return TransactionServiceMock.shared
        } else {
            return TransactionServiceImpl.shared
        }
    }()
}
