//
//  FetchAccountsUseCaseImpl.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Combine
import Foundation

struct FetchAccountsUseCaseImpl: FetchAccountsUseCase {
    private var encoder: JSONEncoder
    private var networkerDi: NetworkerDIContainer
    private var networker: Networker
    
    init(networkerDI: NetworkerDIContainer, encoder: JSONEncoder) {
        networkerDi = networkerDI
        networker = networkerDi.jsonNetworker()
        self.encoder = encoder
    }
    
    func execute(user: any UserId) -> AnyPublisher<Accounts, any Error> {
        let data = try! encoder.encode(user)
        let jsonEndpoint = networkerDi.makeJsonEndpoint(encoded: data, path: "/accounts/list")
            
        return networker
            .request(jsonEndpoint)
            .catch { error -> AnyPublisher<Accounts, Error> in
                Fail(error: PBError.sth("Request failed, try again later"))
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
