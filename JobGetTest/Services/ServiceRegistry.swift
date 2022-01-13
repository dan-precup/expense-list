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
    lazy var transactionService: TransactionService = TransactionServiceImpl.shared
}
