//
//  AppDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class AppDIContainer {
    
    lazy var viewModelDIContainer: ViewModelDIContainer = {
        return ViewModelDIContainer(dependencies: ViewModelDIContainer.Dependencies())
    }()

    lazy var viewDIContainer: ViewDIContainer = {
        return ViewDIContainer(dependencies: ViewDIContainer.Dependencies(
            loginViewModel: viewModelDIContainer.loginViewModel
        ))
    }()
    
    lazy var viewControllerDIContainer: ViewControllerDIContainer = {
        return ViewControllerDIContainer(
            dependencies: ViewControllerDIContainer.Dependencies(
                loginForm: viewDIContainer.loginForm,
                loginViewModel: viewModelDIContainer.loginViewModel
            )
        )
    }()

    lazy var routeCoordinatorDIContainer: RouteCoordinatorDIContainer = {
        return RouteCoordinatorDIContainer(
            dependencies: RouteCoordinatorDIContainer.Dependencies(
                loginViewController: viewControllerDIContainer.loginViewController
            )
        )
    }()
}
