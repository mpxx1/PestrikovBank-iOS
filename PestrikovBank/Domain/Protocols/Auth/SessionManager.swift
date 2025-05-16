//
//  SessionManager.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol SessionManager {
    var currentUserPublisher: AnyPublisher<AuthState, Never> { get }
    func login(creds: Creds) -> AnyPublisher<AuthState, Error>
    func logout() -> AnyPublisher<AuthState, Never>
}
