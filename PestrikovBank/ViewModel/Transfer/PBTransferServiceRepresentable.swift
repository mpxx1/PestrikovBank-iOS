//
//  PBTransferServiceRepresentable.swift
//  PestrikovBank
//
//  Created by m on 05.04.2025.
//

import Foundation

public protocol PBTransferServiceRepresentable {
    associatedtype Account: PBAccountRepresentable
    
    func transfer(from: Account.ID, to: Account.ID, amount: Decimal) -> Result<Void, Error>
}
