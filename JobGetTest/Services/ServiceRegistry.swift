//
//  ServiceRegistry.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

final class ServiceRegistry {
    static let shared = ServiceRegistry()
    let localStorage: LocalStorageService = CoreDataStorage()
}
