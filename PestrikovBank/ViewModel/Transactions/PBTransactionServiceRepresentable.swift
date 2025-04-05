//
//  PBTransactionServiceRepresentable.swift
//  PestrikovBank
//
//  Created by m on 05.04.2025.
//

public protocol PBTransactionServiceRepresentable {
    associatedtype PBAccountRepresentable
    
    func fetchTransactions(for account: PBAccountRepresentable) -> Result<[any PBTransactionRepresentable], Error>
    func fetchTransactions(for account: PBAccountRepresentable, filter by: (any PBTransactionRepresentable) -> Bool) -> Result<[any PBTransactionRepresentable], Error>
}
