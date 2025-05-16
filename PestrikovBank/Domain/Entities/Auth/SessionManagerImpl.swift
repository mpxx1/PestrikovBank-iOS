//
//  SessionManagerImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine
import SwiftKeychainWrapper

public final class SessionManagerImpl: SessionManager {

    static let shared = SessionManagerImpl()
    
    private let userSubject = CurrentValueSubject<AuthState, Never>(.loggedOut)
    public var currentUserPublisher: AnyPublisher<AuthState, Never> {
        userSubject.eraseToAnyPublisher()
    }
    
    private init() {
         if let saved = KeychainWrapper.standard.string(forKey: "userId") {
             // todo send request to serv to get user
             // userSubject.send(.loggedIn(UserImpl))
         }
    }
    
    public func login(creds: Creds) -> AnyPublisher<AuthState, Error> {
        // todo send request to server and set new value to keychain, publish auth state
        
        return Just(.loggedOut) // tmp
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func logout() -> AnyPublisher<AuthState, Never> {
        KeychainWrapper.standard.removeObject(forKey: "userId")
        userSubject.send(.loggedOut)
        return Just(.loggedOut).eraseToAnyPublisher()
    }
}
