//
//  AccountsTabCoordinator.swift
//  PestrikovBank
//
//  Created by m on 21.04.2025.
//

import UIKit

public class AccountsTabCoordinator: RouteCoordinator {
    private var viewControllerDIContainer: ViewControllerDIContainer
    
    public var rootViewController: UIViewController = UINavigationController()
    public var childCoordinators = [UIViewController]()
    
    init(
        viewControllerDIContainer: ViewControllerDIContainer,
    ) {
        self.rootViewController = viewControllerDIContainer.accountsViewController
        self.viewControllerDIContainer = viewControllerDIContainer
    }
    
    public func start() {
        guard let accountsTabViewController = rootViewController as? AccountsViewController else { return }
        
        accountsTabViewController.onAccountTapped = { [weak self] in
            guard let self = self else { return }
            self
                .navigateToController(
                    self.viewControllerDIContainer.accountDetailsViewController
                )
        }
        
        accountsTabViewController.onUserDetailsTapped = { [weak self] in
            guard let self = self else { return }
            self
                .navigateToController(
                    self.viewControllerDIContainer.userDetailsViewController
                )
        }
    }
    
    private func navigateToController(_ controller: UIViewController) {
        childCoordinators.removeAll()
        childCoordinators.append(controller)
        
        let navigation = UINavigationController(rootViewController: childCoordinators[0])
        navigation.modalPresentationStyle = .pageSheet
        navigation.modalTransitionStyle = .coverVertical
        rootViewController.present(navigation, animated: true)
    }
}
