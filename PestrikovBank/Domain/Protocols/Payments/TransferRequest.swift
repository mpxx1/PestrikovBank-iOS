//
//  PBTransferRequestRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

public protocol TransferRequest {
    var sourceAccountId: UUID { get }
    var destinationCardNumber: String { get }
    var amount: Decimal { get }
    var description: String { get }
}
