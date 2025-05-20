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

enum LoginNavigateTo {
    case signUp
}

public final class LoginViewModel: PhoneFormat {
    
    private var cancellables: Set<AnyCancellable> = []
    private var phoneFormatter: PhoneFormat
    var onSignUpTapped = PassthroughSubject<LoginNavigateTo, Never>()
    
    @Published var state: LoginState = .none
    @Published var phoneNumber = ""
    @Published var password = ""
    
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
        bindSessionManager()
    }
    
    public func submitLogin() {
        state = .loading
        
        SessionManagerImpl
            .shared
            .login(creds: AuthCredsImpl(phoneNumber: phoneNumber, password: password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .failed(error)
                    self?.password = ""
                }
            }, receiveValue: { [weak self] authState in
                switch authState {
                case .loggedIn(_):
                    self?.state = .succeeded
                case .loggedOut:
                    self?.state = .failed(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Login failed"]))
                case .loading:
                    self?.state = .loading
                }
            })
            .store(in: &cancellables)
    }
    
    public func didTapSignUpButton() {
        onSignUpTapped
            .send(.signUp)
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
    
    private func bindSessionManager() {
        SessionManagerImpl
            .shared
            .currentUserPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] authState in
                switch authState {
                case .loading:
                    self?.state = .loading
                case .loggedIn:
                    self?.state = .succeeded
                case .loggedOut:
                    if case .loading = self?.state {
                        self?.state = .none
                    }
                }
            }
            .store(in: &cancellables)
    }
}
