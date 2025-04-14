//
//  GetCardsUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine
import Foundation

public protocol GetCardsUseCase {
    func execute(for account: Account.Identifier) -> AnyPublisher<[any Card], Error>
}
