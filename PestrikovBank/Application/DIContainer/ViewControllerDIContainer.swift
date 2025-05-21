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
            viewDIContainer: dependencies.viewDIContainer,
            viewModel: dependencies.modelDIContainer.loginViewModel
        )
    }()
    
    lazy var signUpViewController: SignUpViewController = {
        return SignUpViewController(
            viewDIContainer: dependencies.viewDIContainer,
            signUpViewModel: dependencies.modelDIContainer.signUpViewModel
        )
    }()
    
    lazy var accountsViewController: UIViewController = {
        return AccountsViewController(
            viewModel: dependencies.modelDIContainer.accountsViewModel
        )
    }()
    
    lazy var accountDetailsViewController: UIViewController = {
        return AccountDetailsViewController(
            viewModel: dependencies.modelDIContainer.accountsViewModel
        )
    }()
    
    lazy var dsAccountDetailsViewController: UIViewController = {
        return DSAccountDetailsViewController(
            viewModel: dependencies.modelDIContainer.accountsViewModel,
            viewDIContainer: dependencies.viewDIContainer
        )
    }()
}
