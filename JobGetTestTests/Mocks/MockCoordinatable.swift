//
//  MockCoordinatable.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import UIKit
@testable import JobGetTest

class MockCoordinatable: Coordinatable {
    var navigationController: UINavigationController = UINavigationController()
    var wasPresented = false
    var wasPushed = false
    var wasDismissed = false
    func baseViewController() -> UIViewController? {
        navigationController
    }
    
    func push(_ viewController: UIViewController) {
        wasPushed = true
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        wasPushed = true
    }
    
    func push(_ viewController: UIViewController, animated: Bool, title: String?) {
        wasPushed = true
    }
    
    func present(_ viewController: UIViewController) {
        wasPushed = true
    }
    
    func dismiss() {
        wasDismissed = true
    }
    
    func dismiss(completion: (() -> Void)?) {
        wasDismissed = true
    }
    
    
}
