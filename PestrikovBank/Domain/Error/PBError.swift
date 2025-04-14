//
//  PBError.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

public enum PBError: Error {
    case invalidResponse
    case authError(String)
    case networkError
    case serverError
}
