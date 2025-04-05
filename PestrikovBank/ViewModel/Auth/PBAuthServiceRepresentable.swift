//
//  PBAuthServiceRepresentable.swift
//  PestrikovBank
//
//  Created by m on 03.04.2025.
//

protocol PBAuthServiceRepresentable {
    func auth(_ credentials: PBAuthCredentialsProvider) -> Result<PBAccountRepresentable, Error>
}
