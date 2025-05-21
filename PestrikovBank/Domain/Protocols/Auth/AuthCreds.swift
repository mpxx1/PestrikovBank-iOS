//
//  AuthCreds.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

protocol AuthCreds: Codable {
    var phoneNumber: String { get }
    var password: String { get }
}
