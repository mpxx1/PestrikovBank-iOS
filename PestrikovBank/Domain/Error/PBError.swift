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
    case networkError
    case serverError
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response format, try again later or contact support"
        case .authError(let message):
            return "Authentication error: \(message)"
        case .networkError:
            return "No internet connection"
        case .serverError:
            return "Ooops! Something went wrong"
        }
    }
}
