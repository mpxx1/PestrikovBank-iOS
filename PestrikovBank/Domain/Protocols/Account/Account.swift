//
//  PBAccountRepresentable.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

import Foundation

public protocol Account: Codable {
    var id: Int { get }
    var amount: Decimal { get }
    var variant: AccountVariant { get }
    var createdAt: Date { get }
}

