//
//  PBCardRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

public protocol PBCardRepresentable: Identifiable {
    var id: String { get }  // card number
    var expirationDate: Date { get }
}
