//
//  PBCardServiceRepresentable.swift
//  PestrikovBank
//
//  Created by m on 05.04.2025.
//

public protocol PBCardServiceRepresentable {
    associatedtype Account: PBAccountRepresentable
    
    func fetchCards(account id: Account.ID) -> Result<[any PBCardRepresentable], Error>
    func createCard(account id: Account.ID) -> Result<any PBCardRepresentable, Error>
}
