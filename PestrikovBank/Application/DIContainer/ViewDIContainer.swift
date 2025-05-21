//
//  ViewDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewDIContainer {
    struct Dependencies {
        let modelDIContainer: ViewModelDIContainer
    }
    
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginForm: LoginFormView = {
        return LoginFormView(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies
                .modelDIContainer
                .loginViewModel
                .phoneFormat()
        )
    }()
    
    lazy var signUpForm: SignUpFormView = {
        return SignUpFormView(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies
                .modelDIContainer
                .signUpViewModel
                .phoneFormat()
        )
    }()
}
