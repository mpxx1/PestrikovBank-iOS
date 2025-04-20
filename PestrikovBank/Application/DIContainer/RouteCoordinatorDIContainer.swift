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
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var appCooridnator: RouteCoordinator = {
        return AppCoordinator(
            loginCoordinator: loginCooridnator,
            mainCoordinator: MainCoordinator()  // todo change to func call
        )
    }()
    
    lazy var loginCooridnator: RouteCoordinator = {
        return LoginCoordinator(
            loginViewController: dependencies.loginViewController
        )
    }()
}
