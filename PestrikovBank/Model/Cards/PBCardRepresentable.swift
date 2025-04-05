//
//  PBCardRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

protocol PBCardRepresentable {
    var cardNumber: String { get }
    var expirationDate: Date { get }
}
