//
//  PBCardRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

protocol Card {
    var id: String { get }  // card number
    var expireMonth: Int { get }
    var expireYear: Int { get }
    var designUrl: String { get }
}
