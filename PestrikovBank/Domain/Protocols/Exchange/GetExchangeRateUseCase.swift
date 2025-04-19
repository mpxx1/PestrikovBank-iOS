//
//  GetExchangeRateUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol GetExchangeRateUseCase {
    func execute(from: String, to: String) -> AnyPublisher<ExchangeRate, Error>
}
