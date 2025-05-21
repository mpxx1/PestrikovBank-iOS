//
//  StringFormatDIContainer.swift
//  PestrikovBank
//
//  Created by m on 21.04.2025.
//

public class StringFormatDIContainer {
    lazy var phoneNumberFormatter: PhoneFormat = {
        return DefaultPhoneFormat()
    }()
}
