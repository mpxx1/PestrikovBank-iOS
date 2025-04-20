//
//  ViewDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewDIContainer {
    struct Dependencies {
        let loginViewModel: LoginViewModelImpl
    }
    
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginForm: LoginFormViewImpl = {
        return LoginFormViewImpl(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies.loginViewModel.phoneFormat()
        )
    }()
}
