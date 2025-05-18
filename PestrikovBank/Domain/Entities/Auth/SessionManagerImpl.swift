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
    
    private let networker = JsonNetworker()
    private let userSubject = CurrentValueSubject<AuthState, Never>(.loggedOut)
    
    private var cancellables: Set<AnyCancellable> = []
    public var currentUserPublisher: CurrentValueSubject<AuthState, Never> {
        return userSubject
    }
    
    private init() {
        
        if let saved = KeychainWrapper.standard.string(forKey: "userId"),
           let id = Int(saved) {
            let preData = UserIdImpl(id: id)
            let data = try! JSONEncoder().encode(preData)
        
            self
                .userSubject
                .send(.loading)
            networker
                .request(makeEndpoint(encoded: data, path: "/user/me"))
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(_):
                        self
                            .userSubject
                            .send(.loggedOut)
                    }
                }, receiveValue: { [weak self] user in
                    self?
                        .userSubject
                        .send(.loggedIn(user))
                })
                .store(in: &cancellables)
        } else {
            self
                .userSubject
                .send(.loggedOut)
        }
    }
    
    func login(creds: AuthCreds) -> AnyPublisher<AuthState, Error> {
        let data = try! JSONEncoder().encode(creds)
        
        return networker
            .request(makeEndpoint(encoded: data, path: "/login"))
            .tryMap { (user: UserImpl) -> AuthState in
                KeychainWrapper.standard.set("\(user.id)", forKey: "userId")
                return .loggedIn(user)
            }
            .handleEvents(receiveOutput: { [weak self] authState in
                self?
                    .userSubject
                    .send(authState)
            }, receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?
                        .userSubject
                        .send(.loggedOut)
                }
            })
            .eraseToAnyPublisher()
    }
    
    public func logout() -> AnyPublisher<AuthState, Never> {
        KeychainWrapper.standard.removeObject(forKey: "userId")
        userSubject.send(.loggedOut)
        return Just(.loggedOut).eraseToAnyPublisher()
    }
    
    private func makeEndpoint(encoded: Data, path: String) -> Endpoint {
        return Endpoint(
            baseURL: URL(string: AppConfig.apiBaseURL())!,
            path: path,
            method: .POST,
            headers: ["Content-Type": "application/json", "Content-Length":"\(encoded.count)"],
            body: encoded
        )
    }
}
