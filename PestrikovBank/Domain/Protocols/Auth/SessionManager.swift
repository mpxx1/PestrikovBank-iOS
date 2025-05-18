//
//  SessionManager.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

protocol SessionManager {
    var currentUserPublisher: CurrentValueSubject<AuthState, Never> { get }
    func login(creds: AuthCreds) -> AnyPublisher<AuthState, Error>
    func logout() -> AnyPublisher<AuthState, Never>
}
