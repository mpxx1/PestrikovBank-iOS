//
//  GetAccountsUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol GetAccountsUseCase {
    func execute(for user: User.Identifier) -> AnyPublisher<[any Account], Error>
}
