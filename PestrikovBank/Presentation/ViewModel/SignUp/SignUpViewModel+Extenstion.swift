//
//  SignUpViewModelImpl+Extenstion.swift
//  PestrikovBank
//
//  Created by m on 21.04.2025.
//

import UIKit
import Combine
import Foundation

enum SignUpState {
    case none
    case loading
    case succeeded
    case failed(Error)
}

public final class SignUpViewModel {
    
    private var phoneFromat: PhoneFormat
    @Published var state: LoginState = .none
    @Published var phoneNumber = ""
    @Published var secret = ""
    @Published var confirmSecret = ""
    
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
    
    var isValidConfirmSecret: AnyPublisher<Bool, Never> {
        $confirmSecret
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isSignUpEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(
            $phoneNumber.prepend(""),
            $secret.prepend(""),
            $confirmSecret.prepend("")
        )
        .map { phone, secret, confirm in
            phone.isValidPhoneNumber() &&
            !secret.isEmpty &&
            !confirm.isEmpty &&
            secret == confirm
        }
        .eraseToAnyPublisher()
    }
    
    init(phoneFormatter: PhoneFormat) {
        self.phoneFromat = phoneFormatter
    }
    
    func submitSignUp() {
        state = .loading
        
        DispatchQueue
            .main
            .async { [weak self] in
                
                guard let self else { return }
                
                switch self.processSignUp() {
                case .success:
                    self.state = .succeeded
                case .failure(let error):
                    self.state = .failed(error)
                }
            }
    }
    
    func processSignUp() -> Result<Void, Error> {
        // sign up request
        // create creds object
        // pass it to async servier request use case
        
        let tmp = true
        
        if tmp {
            return .success(())
        } else {
            return .failure(PBError.authError("test"))
        }
    }
}

extension SignUpViewModel: PhoneFormat {
    public var maxLength: Int {
        return phoneFromat.maxLength
    }
    
    public var regex: NSRegularExpression {
        phoneFromat.regex
    }
    
    public func phoneFormat() -> (String, Bool) -> String {
        phoneFromat.phoneFormat()
    }
}
