//
//  ViewModelDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewModelDIContainer {
    struct Dependencies {
        let phoneFormatter: PhoneFormat
        let useCasesDIContainer: UseCasesDIContainer
    }
    
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel(
            phoneFromat: dependencies.phoneFormatter
        )
    }()
    
    lazy var signUpViewModel: SignUpViewModel = {
        return SignUpViewModel(
            phoneFormatter: dependencies.phoneFormatter,
            signUpUseCase: dependencies.useCasesDIContainer.signUpUseCase
        )
    }()
    
    lazy var accountsViewModel: AccountsViewModel = {
        return AccountsViewModelImpl(
            fetchAccountsUseCase: dependencies.useCasesDIContainer.fetchAccountsUseCase,
            fetchCardsUseCase: dependencies.useCasesDIContainer.fetchCardsUseCase
        )
    }()
}
