//
//  PBTransactionRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

protocol PBTransactionRepresentable {
    var id: Int64 { get }
    var sourceUserId: Int64 { get }
    var destinationUserId: Int64 { get }
    var amount: Decimal { get }
    var timestamp: DateComponents { get }
    var description: String { get }
}
