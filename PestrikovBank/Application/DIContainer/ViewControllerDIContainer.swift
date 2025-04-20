//
//  ViewControllerDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewControllerDIContainer {
    struct Dependencies {
        let loginForm: LoginFormViewImpl
        let loginViewModel: LoginViewModelImpl
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginViewController: LoginViewControllerImpl = {
        return LoginViewControllerImpl(
            loginForm: dependencies.loginForm,
            viewModel: dependencies.loginViewModel
        )
    }()
}
