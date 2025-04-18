//
//  LoginViewModelImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Foundation
import Combine

enum LoginState {
    case none
    case loading
    case succeeded
    case failed(Error)
}

public final class LoginViewModelImpl {
    @Published var state: LoginState = .none
    @Published var phoneNumber = ""
    @Published var secret = ""
    
    var isValidPhoneNumber: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.isValidPhoneNumber() }
            .eraseToAnyPublisher()
    }
    
    var isValidSecret: AnyPublisher<Bool, Never> {
        $secret
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isLoginEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isValidPhoneNumber,
            isValidSecret
        )
        .map { $0 && $1 }
        .eraseToAnyPublisher()
    }
    
    func submitLogin() {
        state = .loading
        
        DispatchQueue
            .main
            .async { [weak self] in
                
                guard let self else { return }
                
                switch self.isCorrectLogin() {
                case .success:
                    self.state = .succeeded
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
    }
    
    func isCorrectLogin() -> Result<Void, Error> {
        // login request
        // create creds object
        // pass it to async servier request use case
        
        return .failure(PBError.authError("test"))
    }
}
