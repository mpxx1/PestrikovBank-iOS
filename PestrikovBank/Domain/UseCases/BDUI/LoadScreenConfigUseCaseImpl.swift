//
//  LoadScreenConfigUseCaseImpl.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import Combine
import Foundation

final class LoadScreenConfigUseCaseImpl: LoadScreenConfigUseCase {
    private var encoder: JSONEncoder
    private var networkerDi: NetworkerDIContainer
    private var networker: Networker
    private var cancellabels: Set<AnyCancellable> = []
    
    init(networkerDI: NetworkerDIContainer, encoder: JSONEncoder) {
        networkerDi = networkerDI
        networker = networkerDi.jsonNetworker()
        self.encoder = encoder
    }
    
    func execute(user: UserId, path: String) async throws -> ScreenConfig {
        let data = try! encoder.encode(user)
        let jsonEndpoint = networkerDi.makeJsonEndpoint(encoded: data, path: path)
            
        return try await withCheckedThrowingContinuation { continuation in
            networker
                .request(jsonEndpoint)
                .first()
                .sink(
                    receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            continuation.resume(throwing: error)
                        }
                    },
                    receiveValue: { value in
                        continuation.resume(returning: value)
                    }
                ).store(in: &self.cancellabels)
        }
    }
}
