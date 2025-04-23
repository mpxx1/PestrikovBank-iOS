//
//  ViewControllerDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewControllerDIContainer {
    struct Dependencies {
        let loginForm: LoginFormView
        let loginViewModel: LoginViewModel
        let signUpForm: SignUpFormView
        let signUpViewModel: SignUpViewModel
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginViewController: UIViewController = {
        return LoginViewController(
            loginForm: dependencies.loginForm,
            viewModel: dependencies.loginViewModel
        )
    }()
    
    lazy var signUpViewController: SignUpViewController = {
        return SignUpViewController(
            signUpForm: dependencies.signUpForm,
            signUpViewModel: dependencies.signUpViewModel
        )
    }()
}
