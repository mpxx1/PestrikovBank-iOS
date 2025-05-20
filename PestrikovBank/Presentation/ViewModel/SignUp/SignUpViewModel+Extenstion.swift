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

    private var cancellables: Set<AnyCancellable> = []
    private var signUpUseCase: SignUpUseCase
    private var phoneFromat: PhoneFormat
    @Published var state: SignUpState = .none
    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var confirmSecret = ""
    
    var isValidPhoneNumber: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map { $0.isValidPhoneNumber() }
            .eraseToAnyPublisher()
    }
    
    var isValidSecret: AnyPublisher<Bool, Never> {
        $password
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
            $password.prepend(""),
            $confirmSecret.prepend("")
        )
        .map { phone, password, confirm in
            phone.isValidPhoneNumber() &&
            !password.isEmpty &&
            !confirm.isEmpty &&
            password == confirm
        }
        .eraseToAnyPublisher()
    }
    
    init(phoneFormatter: PhoneFormat, signUpUseCase: SignUpUseCase) {
        self.phoneFromat = phoneFormatter
        self.signUpUseCase = signUpUseCase
    }
    
    func submitSignUp() {
        state = .loading
        
        signUpUseCase
            .execute(
                creds: AuthCredsImpl(
                    phoneNumber: phoneNumber,
                    password: password
                )
            )
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .failed(error)
                }
            } receiveValue: { [weak self] user in

                self?.state = .succeeded
            }
            .store(in: &cancellables)

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
