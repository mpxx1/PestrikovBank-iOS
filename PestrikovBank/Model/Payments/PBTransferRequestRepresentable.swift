//
//  PBTransferRequestRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

protocol PBTransferRequestRepresentable {
    var sourceAccountId: UUID { get }
    var destinationCardNumber: String { get }
    var amount: Decimal { get }
    var description: String { get }
}
