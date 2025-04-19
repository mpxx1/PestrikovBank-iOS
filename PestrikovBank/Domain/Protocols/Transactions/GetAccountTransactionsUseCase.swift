//
//  GetAccountTransactionsUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine
import Foundation

public protocol GetAccountTransactionsUseCase {
    typealias TransactionFilter = (any Transaction) -> Bool
    
    func execute(for account: Account.Identifier) -> AnyPublisher<[any Transaction], Error>
    func filtered(
        for account: Account.Identifier,
        filter by: TransactionFilter
    ) -> AnyPublisher<[any Transaction], Error>
}
