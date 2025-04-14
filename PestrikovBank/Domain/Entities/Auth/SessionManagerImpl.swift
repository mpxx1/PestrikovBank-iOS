//
//  SessionManagerImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public final class SessionManagerImpl: SessionManager {
    
    @Published private(set) public var authState: AuthState = .loggedOut
    
    public static let shared = SessionManagerImpl()
    private init() {}
    
    public func startSession(with authTokens: any AuthTokens) -> AnyPublisher<Void, any Error> {
        authState = .loggedIn(authTokens)
        
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func endSession() -> AnyPublisher<Void, any Error> {
        authState = .loggedOut
        
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
