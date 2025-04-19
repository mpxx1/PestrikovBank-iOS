//
//  AuthTokensImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Foundation

public struct AutAuthTokensImpl: AuthTokens {
    public let accessToken: String
    public let refreshToken: String
    public let expiresAt: Date
}
