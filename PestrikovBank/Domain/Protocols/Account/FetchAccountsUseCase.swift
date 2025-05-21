//
//  FetchAccountsUseCase.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Combine

protocol FetchAccountsUseCase {
    func execute(user: UserId) -> AnyPublisher<Accounts, Error>
}
