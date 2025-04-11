//
//  PBExchangeCurrencyServiceRepresentable.swift
//  PestrikovBank
//
//  Created by m on 05.04.2025.
//

import Foundation

public protocol PBExchangeCurrencyServiceRepresentable {
    func getCurrencyExchangeRate(from: String, to: String) -> Result<Decimal, Error>
}
