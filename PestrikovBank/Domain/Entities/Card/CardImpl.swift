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
    var id: String
    var expireMonth: Int
    var expireYear: Int
    var designUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expireMonth = "expire_month"
        case expireYear = "expire_year"
        case designUrl = "design_url"
    }
}
