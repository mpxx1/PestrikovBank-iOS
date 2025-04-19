//
//  PhoneFormat.swift
//  PestrikovBank
//
//  Created by m on 19.04.2025.
//

import Foundation

public protocol PhoneFormat {
    var maxLength: Int { get }
    var regex: NSRegularExpression { get }

    func phoneFormat() -> (String, Bool) -> String
}
