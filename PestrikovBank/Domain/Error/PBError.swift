//
//  PBError.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

public enum PBError: LocalizedError {
    case invalidResponse
    case authError(String)
    case network(Error)
    case keychain(Error)
    case server(statusCode: Int)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response format, try again later or contact support"
        case .authError(let message):
            return "Authentication error: \(message)"
        case .network(let e):
            return "No internet connection. \(e.localizedDescription)"
        case .server(let e):
            return "Ooops! Something went wrong. Server error: \(e)"
        case .keychain(_):
            return "Can not fetch keychain data"
        }
    }
}
