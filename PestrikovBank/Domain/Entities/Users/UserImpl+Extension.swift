//
//  UserImpl.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Foundation

public struct UserImpl: User, Codable {
    public var id: Int
    public var phoneNumber: String
    public var firstName: String?
    public var lastName: String?
    public var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case phoneNumber = "phone_number"
        case firstName = "first_name"
        case lastName = "last_name"
        case createdAt = "created_at"
    }
}

extension JSONDecoder {
    static let postgresDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            // Поддержка разных форматов
            formatter.dateFormat = "yyyy-MM-dd" // "2025-05-15"
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // "2025-05-15 14:30:00"
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // "2025-05-15T14:30:00Z"
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date string does not match expected formats: \(dateString)")
        }
        return decoder
    }()
}
