//
//  PBUserRepresentable.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

import Foundation

public protocol User: Codable {
    var id: Int { get }
    var phoneNumber: String { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var createdAt: Date { get }
}
