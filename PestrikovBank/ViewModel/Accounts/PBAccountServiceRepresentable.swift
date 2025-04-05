//
//  PBAccountServiceRepresentable.swift
//  PestrikovBank
//
//  Created by m on 05.04.2025.
//

import Foundation

public protocol PBAccountServiceRepresentable {
    associatedtype User: PBUserRepresentable
    
    func fetchAccounts(for userId: User.ID) -> Result<[any PBAccountRepresentable], Error>
    func fetchAccounts(for userId: User.ID, filter by: (any PBAccountRepresentable) -> Bool) -> Result<[any PBAccountRepresentable], Error>
    func openAccount(
        for userId: User.ID,
        ofVariant variant: PBAccountVariant,
        withInitialAmount amount: Decimal
    ) -> Result<any PBAccountRepresentable, Error>
}
