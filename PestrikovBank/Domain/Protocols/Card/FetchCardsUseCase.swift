//
//  FetchCardsUseCase.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Combine

protocol FetchCardsUseCase {
    func execute(user: UserId) -> AnyPublisher<Cards, Error>
}
