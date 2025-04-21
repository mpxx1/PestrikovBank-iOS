//
//  AppDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class AppDIContainer {
    
    lazy var stringFormatDIContainer: StringFormatDIContainer = {
        return StringFormatDIContainer()
    }()
    
    lazy var viewModelDIContainer: ViewModelDIContainer = {
        return ViewModelDIContainer(dependencies: ViewModelDIContainer.Dependencies(
            phoneFormatter: stringFormatDIContainer.phoneNumberFormatter
        ))
    }()

    lazy var viewDIContainer: ViewDIContainer = {
        return ViewDIContainer(dependencies: ViewDIContainer.Dependencies(
            loginViewModel: viewModelDIContainer.loginViewModel,
            signUpViewModel: viewModelDIContainer.signUpViewModel
        ))
    }()
    
    lazy var viewControllerDIContainer: ViewControllerDIContainer = {
        return ViewControllerDIContainer(
            dependencies: ViewControllerDIContainer.Dependencies(
                loginForm: viewDIContainer.loginForm,
                loginViewModel: viewModelDIContainer.loginViewModel,
                signUpForm: viewDIContainer.signUpForm,
                signUpViewModel: viewModelDIContainer.signUpViewModel
            )
        )
    }()

    lazy var routeCoordinatorDIContainer: RouteCoordinatorDIContainer = {
        return RouteCoordinatorDIContainer(
            dependencies: RouteCoordinatorDIContainer.Dependencies(
                loginViewController: viewControllerDIContainer.loginViewController,
                signUpViewController: viewControllerDIContainer.signUpViewController
            )
        )
    }()
}
