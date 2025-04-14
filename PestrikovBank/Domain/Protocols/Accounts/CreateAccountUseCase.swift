//
//  OpenAccountUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine
import Foundation

protocol CreateAccountUseCase {
    func execute(
        for user: User.Identifier,
        of type: AccountVariant,
        with startAmount: Decimal
    ) -> AnyPublisher<any Account, Error>
}
