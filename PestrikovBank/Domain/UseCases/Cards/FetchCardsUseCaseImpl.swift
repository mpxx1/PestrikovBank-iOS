//
//  FetchCardsUseCaseImpl.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Combine
import Foundation

struct FetchCardsUseCaseImpl: FetchCardsUseCase {
    private var encoder: JSONEncoder
    private var networkerDi: NetworkerDIContainer
    private var networker: Networker
    
    init(networkerDI: NetworkerDIContainer, encoder: JSONEncoder) {
        networkerDi = networkerDI
        networker = networkerDi.jsonNetworker()
        self.encoder = encoder
    }
    
    func execute(user: UserId) -> AnyPublisher<[CardImpl], any Error> {
        let data = try! encoder.encode(user)
        let jsonEndpoint = networkerDi.makeJsonEndpoint(encoded: data, path: "/user/signup")
        
        return networker
            .request(jsonEndpoint)
            .catch { error -> AnyPublisher<[CardImpl], Error> in
                Fail(error: PBError.sth("Request failed, try again later"))
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
