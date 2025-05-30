//
//  RouteCoordinatorDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class RouteCoordinatorDIContainer {
    struct Dependencies {
        let controllerDIContainer: ViewControllerDIContainer
        let viewModelDIContainer: ViewModelDIContainer
        let viewDIContainer: ViewDIContainer
        let networkDIContainer: NetworkerDIContainer
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginCooridnator: RouteCoordinator = {
        return LoginCoordinator(
            loginViewController: dependencies.controllerDIContainer.loginViewController,
            signUpViewController: dependencies.controllerDIContainer.signUpViewController
        )
    }()
    
    lazy var accountsTabCoordinator: RouteCoordinator = {
        return AccountsTabCoordinator(
            accountsViewController: dependencies
                .controllerDIContainer
                .accountsViewController,
            aboutAccountViewModel: dependencies
                .viewModelDIContainer
                .accountsViewModel,
            viewDIContainer: dependencies.viewDIContainer
            
        )
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
