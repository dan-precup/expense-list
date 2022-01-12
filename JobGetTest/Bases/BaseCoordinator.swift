//
//  BaseCoordinator.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

class BaseCoordinator: Coordinatable {
    let navigationController: UINavigationController

    init(_ navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func setController(_ viewController: UIViewController, animated: Bool = true, title: String? = nil) {
        setControllers([viewController], animated: animated)
        if let title = title {
            viewController.title = title
        }
    }

    func setControllers(_ viewControllers: [UIViewController], animated: Bool = true) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }

    func baseViewController() -> UIViewController? {
        navigationController
    }
    
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true, title: nil)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, title: nil)
    }
    
    func push(_ viewController: UIViewController, animated: Bool, title: String?) {
        navigationController.pushViewController(viewController, animated: animated)
        if let title = title {
            viewController.title = title
        }
    }
    
    func present(_ viewController: UIViewController) {
        present(viewController, presentationStyle: .fullScreen)
    }
    
    func present(_ viewController: UIViewController, presentationStyle: UIModalPresentationStyle) {
        viewController.modalPresentationStyle = presentationStyle
        navigationController.present(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController, over: UIViewController?) {
        viewController.modalPresentationStyle = .fullScreen
        over?.present(viewController, animated: true)
    }
    
    func backToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func back(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        navigationController.dismiss(animated: true, completion: completion)
    }
}
