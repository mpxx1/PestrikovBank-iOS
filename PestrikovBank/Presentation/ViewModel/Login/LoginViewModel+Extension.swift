//
//  LoginViewModelImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import UIKit
import Combine
import Foundation

enum LoginState {
    case none
    case loading
    case succeeded
    case failed(Error)
}

public final class LoginViewModel: PhoneFormat {
    
    private var phoneFormatter: PhoneFormat
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
    
    init(phoneFromat: PhoneFormat) {
        self.phoneFormatter = phoneFromat
    }
    
    public func submitLogin() {
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
    
    public var maxLength: Int {
        return phoneFormatter.maxLength
    }
    
    public var regex: NSRegularExpression {
        phoneFormatter.regex
    }
    
    public func phoneFormat() -> (String, Bool) -> String {
        phoneFormatter.phoneFormat()
    }
    
    private func isCorrectLogin() -> Result<Void, Error> {
        // login request
        // create creds object
        // pass it to async servier request use case
        
        let tmp = true
        
        if tmp {
            SessionManagerImpl
                .shared
                .startSession(
                    with: AutAuthTokensImpl(
                        accessToken: "t1",
                        refreshToken: "t2"
                    )
                )
            
            return .success(())
        } else {
            return .failure(PBError.authError("test"))
        }
    }
}
