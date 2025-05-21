//
//  PBError.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

import Foundation

public enum PBError: LocalizedError {
    case invalidResponse
    case network(Error)
    case keychain(Error)
    case server(ErrorResponse)
    case sth(String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response format, try again later or contact support"
        case .network(let e):
            return "\(e.localizedDescription)"
        case .server(let e):
            return "Ooops! Something went wrong. Error code: \(e.errorCode), message: \(e.errorMessage)"
        case .keychain(_):
            return "Can not fetch keychain data"
        case .sth(let e):
            return e
        }
    }
}
