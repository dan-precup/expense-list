//
//  TransactionService.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import CoreData
import Foundation

final class TransactionServiceImpl: TransactionService {
    
    /// Singleton instance
    static let shared = TransactionServiceImpl()
    
    /// The persistence layer service
    private let storage: LocalStorageService
    
    private init(storage: LocalStorageService = ServiceRegistry.shared.localStorage) {
        self.storage = storage
    }
    
    /// Create a transaction
    /// - Parameters:
    ///   - name: The transaction name
    ///   - amount: The transaction amount
    ///   - type: The transaction type
    func create(name: String, amount: Double, type: TransactionType) {
        guard let context = storage.getContext() else { return }
        let transaction = Transaction(context: context)
        transaction.amount = amount
        transaction.name = name
        transaction.trasactionType = Int32(type.rawValue)
        transaction.date = Date()
        
        storage.saveContext(context)
    }
    
    /// Get the transaction list
    /// - Returns: A transactions array
    func getTransactions() -> [SingleTransaction] {
        guard let context = storage.getMainContext() else { return [] }
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return (try context.fetch(fetchRequest) as [Transaction]).map({SingleTransaction.from(transaction: $0)})
        } catch {
            Log.error("Cannot get transactions" ,error)
        }
        return []
    }
    
    /// Delete a transaction
    /// - Parameter transaction: The transaction to delete
    func deleteTransaction(_ transaction: SingleTransaction) {
        guard let transaction = transaction.transaction, let context = storage.getMainContext() else { return }
        context.delete(transaction)
        storage.saveContext(context)
    }
}
