//
//  ViewDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewDIContainer {
    struct Dependencies {
        let loginViewModel: LoginViewModel
        let signUpViewModel: SignUpViewModel
    }
    
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginForm: LoginFormView = {
        return LoginFormView(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies.loginViewModel.phoneFormat()
        )
    }()
    
    lazy var signUpForm: SignUpFormView = {
        return SignUpFormView(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies.signUpViewModel.phoneFormat()
        )
    }()
}
