//
//  RouteCoordinatorDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class RouteCoordinatorDIContainer {
    struct Dependencies {
        let loginViewController: UIViewController
        let signUpViewController: UIViewController
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginCooridnator: RouteCoordinator = {
        return LoginCoordinator(
            loginViewController: dependencies.loginViewController,
            signUpViewController: dependencies.signUpViewController
        )
    }()
    
    lazy var accountsTabCoordinator: RouteCoordinator = {
        return AccountsTabCoordinator(rootViewController: UIViewController())
    }()
    
    lazy var transactionsTabCoordinator: RouteCoordinator = {
        return TransactionsTabCoordinator(rootViewController: UIViewController())
    }()
    
    lazy var paymentsTabCoordinator: RouteCoordinator = {
        return PaymentsTabCoordinator(rootViewController: UIViewController())
    }()
    
    lazy var mainCoordinator: RouteCoordinator = {
        return MainCoordinator(
            accountsTabCoordinator: accountsTabCoordinator,
            paymentsTabCoordinator: paymentsTabCoordinator,
            transactionsTabCoordinator: transactionsTabCoordinator
        )
    }()
}
