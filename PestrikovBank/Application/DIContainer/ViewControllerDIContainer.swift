//
//  ViewControllerDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewControllerDIContainer {
    struct Dependencies {
        let viewDIContainer: ViewDIContainer
        let modelDIContainer: ViewModelDIContainer
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginViewController: UIViewController = {
        return LoginViewController(
            loginForm: dependencies.viewDIContainer.loginForm,
            viewModel: dependencies.modelDIContainer.loginViewModel
        )
    }()
    
    lazy var signUpViewController: SignUpViewController = {
        return SignUpViewController(
            signUpForm: dependencies.viewDIContainer.signUpForm,
            signUpViewModel: dependencies.modelDIContainer.signUpViewModel
        )
    }()
    
    lazy var accountsViewController: UIViewController = {
        return AccountsViewController(
            viewModel: dependencies.modelDIContainer.accountsViewModel
        )
    }()
    
    lazy var accountDetailsViewController: UIViewController = {
        return AboutAccountViewControler(
            viewModel: dependencies.modelDIContainer.accountsViewModel
        )
    }()
}
