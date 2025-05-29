//
//  CardImpl.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import Foundation

public struct Cards: Codable {
    let cards: [CardImpl]
}

public struct CardImpl: Card, Codable {
    public let id: String
    public let expireMonth: Int
    public let expireYear: Int
    public let designUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expireMonth = "expire_month"
        case expireYear = "expire_year"
        case designUrl = "design_url"
    }
}
