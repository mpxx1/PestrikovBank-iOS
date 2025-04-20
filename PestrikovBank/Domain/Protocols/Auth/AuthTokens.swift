//
//  AuthTokens.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Foundation

public protocol AuthTokens {
    var accessToken: String { get }
    var refreshToken: String { get }
}
