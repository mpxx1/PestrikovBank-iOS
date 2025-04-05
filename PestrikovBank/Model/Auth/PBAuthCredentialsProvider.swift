//
//  PBAuthCredentialsProvider.swift
//  PestrikovBank
//
//  Created by m on 3/27/25.
//

protocol PBAuthCredentialsProvider {
    var login: String { get }
    var secret: String { get }
}
