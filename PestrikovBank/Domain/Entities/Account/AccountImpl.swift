//
//  AccountImpl+Extension.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Foundation

public struct Accounts: Codable {
    var accounts: [AccountImpl]
}

public struct AccountImpl: Account, Codable {
    public var id: Int
    public var amount: Decimal
    public var variant: AccountVariant
    public var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case variant = "type"
        case createdAt = "created_at"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        let amountInt = try container.decode(Int.self, forKey: .amount)
        self.amount = Decimal(amountInt) / 100
        
        self.variant = try container.decode(AccountVariant.self, forKey: .variant)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        
        let amountInt = amount * Decimal(100)
        
        let roundedAmount = NSDecimalNumber(decimal: amountInt).rounding(accordingToBehavior: NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: 0,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )).intValue
        
        try container.encode(roundedAmount, forKey: .amount)
        
        try container.encode(variant, forKey: .variant)
        try container.encode(createdAt, forKey: .createdAt)
    }
}
