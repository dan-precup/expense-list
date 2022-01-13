//
//  MockHomeCoordinator.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import UIKit
@testable import JobGetTest

final class MockHomeCoordinator: MockCoordinatable, HomeCoordinator {
    var addViewWasPresented = false
    func presentAddEntryForm(delegate: AddEntryDelegate?) {
        addViewWasPresented = true
    }
}
