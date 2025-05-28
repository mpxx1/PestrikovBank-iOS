//
//  AccountsFormViewDelegate.swift
//  PestrikovBank
//
//  Created by m on 25.05.2025.
//

public protocol AccountsFormViewEventHandling: AnyObject {
    func didTapUserDetails()
    func didSelectAccount(at index: Int)
}
