//
//  PBAccountRepresentable.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

import Foundation

public protocol Account: Identifiable {
    typealias Identifier = UUID
    var id: Identifier { get }
    var balance: Decimal { get }
    var currency: String { get }
    var cards: [any Card] { get }
    var transactions: [any Transaction] { get }
}
