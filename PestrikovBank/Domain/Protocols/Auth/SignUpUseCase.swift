//
//  SignUpUseCase.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Combine

protocol SignUpUseCase {
    func execute(creds: AuthCreds) -> AnyPublisher<UserImpl, Error>
}
