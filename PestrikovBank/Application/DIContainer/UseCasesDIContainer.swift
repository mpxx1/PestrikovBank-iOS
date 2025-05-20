//
//  UseCasesDIContainer.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Foundation

final class UseCasesDIContainer {
    
    struct Dependencies {
        var networkerDI: NetworkerDIContainer
        var jsonEncoder: JSONEncoder
    }
    
    private let dependencies: Dependencies
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var signUpUseCase: SignUpUseCase = {
        return SignUpUseCaseImpl(
            networkerDI: dependencies.networkerDI,
            encoder: dependencies.jsonEncoder
        )
    }()
    
    lazy var fetchAccountsUseCase: FetchAccountsUseCase = {
        return FetchAccountsUseCaseImpl(
            networkerDI: dependencies.networkerDI,
            encoder: dependencies.jsonEncoder
        )
    }()
    
    lazy var fetchCardsUseCase: FetchCardsUseCase = {
        return FetchCardsUseCaseImpl(
            networkerDI: dependencies.networkerDI,
            encoder: dependencies.jsonEncoder
        )
    }()

//    lazy var fetchTransactionsUseCase: FetchTransactionsUseCase = {
//    
//    }()
}
