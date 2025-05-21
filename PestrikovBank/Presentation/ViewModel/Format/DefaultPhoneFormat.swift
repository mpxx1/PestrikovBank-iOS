//
//  DefaultPhoneFormat.swift
//  PestrikovBank
//
//  Created by m on 21.04.2025.
//

import Foundation

public class DefaultPhoneFormat: PhoneFormat {
    public var maxLength: Int {
        return 11
    }
    
    public var regex: NSRegularExpression {
        try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    }
    
    public func phoneFormat() -> (String, Bool) -> String {
        return { phoneNumber, shouldRemoveLastDigit in
            guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
            
            let range = NSString(string: phoneNumber).range(of: phoneNumber)
            var number = self.regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
            
            if number.count > self.maxLength {
                let maxIndex = number.index(number.startIndex, offsetBy: self.maxLength)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            if shouldRemoveLastDigit {
                let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            let regRange = number.startIndex..<maxIndex
            
            if number.count < 7 {
                let pattern = "(\\d)(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            } else {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            }
            
            return "+" + number
        }
    }
}
