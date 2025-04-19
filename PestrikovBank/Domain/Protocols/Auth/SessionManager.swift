//
//  SessionManager.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol SessionManager {
    var authState: AuthState { get }
    func startSession(with authTokens: AuthTokens) -> AnyPublisher<Void, Error>
    func endSession() -> AnyPublisher<Void, Error>
}
