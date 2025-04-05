//
//  PBUserRepresentable.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

import Foundation

public protocol PBUserRepresentable: Identifiable {
    var id: Int64 { get }
    var email: String? { get }
    var phoneNumber: String? { get }
    var accounts: [any PBAccountRepresentable] { get }
    var firstName: String { get }
    var lastName: String { get }
    var avatarURL: URL? { get }
    var isVerified: Bool { get }
    var isBlocked: Bool { get }
}
