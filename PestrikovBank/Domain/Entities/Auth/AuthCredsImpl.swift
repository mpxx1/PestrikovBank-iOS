//
//  AuthCredsImpl.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

struct AuthCredsImpl: AuthCreds {
    public let phoneNumber: String
    public let password: String
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case password
    }
}
