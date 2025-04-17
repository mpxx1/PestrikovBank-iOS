//
//  String+Extension.swift
//  PestrikovBank
//
//  Created by m on 16.04.2025.
//

import Foundation

extension String {
    struct PhoneValidation {
        private static let phoneRegex = #"^(?:\+7|8)\s?\(?\d{3}\)?[\s-]?\d{3}[\s-]?\d{2}[\s-]?\d{2}$"#
        static let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    }
    
    func isValidPhoneNumber() -> Bool {
        return PhoneValidation.phonePredicate.evaluate(with: self)
    }
}
