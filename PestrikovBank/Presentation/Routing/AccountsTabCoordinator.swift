//
//  AccountsTabCoordinator.swift
//  PestrikovBank
//
//  Created by m on 21.04.2025.
//

import UIKit

public class AccountsTabCoordinator: RouteCoordinator {
    public var rootViewController: UIViewController = UINavigationController()
    public var childCoordinators = [UIViewController]()
    private var aboutAccountViewModel: AccountsViewModel
    private var viewDIContainer: ViewDIContainer
    
    init(
        accountsViewController: UIViewController,
        aboutAccountViewModel: AccountsViewModel,
        viewDIContainer: ViewDIContainer
    ) {
        self.rootViewController = accountsViewController
        self.aboutAccountViewModel = aboutAccountViewModel
        self.viewDIContainer = viewDIContainer
    }
    
    public func start() {
        guard let accountsTabViewController = rootViewController as? AccountsViewController else { return }
        
        accountsTabViewController.onAccountTapped = { [weak self] in
            self?.navigeteToAccountDetails()
        }
    }
    
    private func navigeteToAccountDetails() {
        let detailsController = AccountDetailsViewController(viewModel: aboutAccountViewModel)
        childCoordinators.append(detailsController)
        
        let navigation = UINavigationController(rootViewController: childCoordinators[0])
        navigation.modalPresentationStyle = .pageSheet
        navigation.modalTransitionStyle = .coverVertical
        rootViewController.present(navigation, animated: true)
    }
}
