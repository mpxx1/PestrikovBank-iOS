//
//  ServerResponse.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

public struct ErrorResponse: Codable {
    public let errorCode: Int
    public let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
    
    
}
