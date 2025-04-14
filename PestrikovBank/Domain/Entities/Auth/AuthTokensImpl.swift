//
//  AuthTokensImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Foundation

public struct AutAuthTokensImpl: AuthTokens {
    private(set) public var accessToken: String
    private(set) public var refreshToken: String
    private(set) public var expiresAt: Date
}
