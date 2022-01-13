//
//  Coordinatable.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

protocol Coordinatable: AnyObject {
    var navigationController: UINavigationController { get }
    func baseViewController() -> UIViewController?
    func push(_ viewController: UIViewController)
    func push(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool, title: String?)
    func present(_ viewController: UIViewController)
    func dismiss()
    func dismiss(completion: (() -> Void)?)
}
