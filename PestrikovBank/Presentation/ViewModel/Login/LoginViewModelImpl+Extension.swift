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

extension LoginViewModelImpl: PhoneFormat {
    public var maxLength: Int {
        return 11
    }
    
    public var regex: NSRegularExpression {
        try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    }
    
    public func phoneFormat() -> (String, Bool) -> String {
        return { phoneNumber, shouldRemoveLastDigit in
            guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
            
            let range = NSString(string: phoneNumber).range(of: phoneNumber)
            var number = self.regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
            
            if number.count > self.maxLength {
                let maxIndex = number.index(number.startIndex, offsetBy: self.maxLength)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            if shouldRemoveLastDigit {
                let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            let regRange = number.startIndex..<maxIndex
            
            if number.count < 7 {
                let pattern = "(\\d)(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            } else {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            }
            
            return "+" + number
        }
    }
}
