//
//  PBCardRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

public protocol Card: Identifiable {
    typealias Identifier = String   // card number
    var id: Identifier { get }
    var expirationDate: Date { get }
}
