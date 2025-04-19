//
//  LoginUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol LoginUseCase {
    func execute(with creds: Creds) -> AnyPublisher<any AuthTokens, Error>
}
