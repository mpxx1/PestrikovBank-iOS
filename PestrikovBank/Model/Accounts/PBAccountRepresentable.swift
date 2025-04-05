//
//  PBAccountRepresentable.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

import Foundation

protocol PBAccountRepresentable {
    var id: UUID { get }
    var balance: Decimal { get }
    var currency: String { get }
    var cards: [PBCardRepresentable] { get }
    var transactions: [PBTransactionRepresentable] { get }
}
