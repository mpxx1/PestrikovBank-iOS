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
        let mapper: PBMapper
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
    
    lazy var userDetailsViewController: UIViewController = {
        return BDUIDefaultViewController(
            viewModel: dependencies.modelDIContainer.bduiDefaultViewModel,
            mapper: dependencies.mapper,
            endpoint: "/bdui/screen-config/user-details"
        )
    }()
}
