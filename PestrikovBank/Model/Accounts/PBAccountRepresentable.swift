//
//  PBAccountRepresentable.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

import Foundation

public protocol PBAccountRepresentable: Identifiable {
    var id: UUID { get }
    var balance: Decimal { get }
    var currency: String { get }
    var cards: [any PBCardRepresentable] { get }
    var transactions: [any PBTransactionRepresentable] { get }
}
