//
//  PBExchangeRateRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

public protocol ExchangeRate {
    var sourceCurrency: String { get }
    var destinationCurrency: String { get }
    var rate: Decimal { get }
    var updatedAt: DateComponents { get }
}
