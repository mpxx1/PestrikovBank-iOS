//
//  AccountsFormViewDelegate.swift
//  PestrikovBank
//
//  Created by m on 25.05.2025.
//

import UIKit

public final class AccountsFormViewDelegate: NSObject {
    private weak var delegate: AccountsFormViewEventHandling?
        
    init(delegate: AccountsFormViewEventHandling) {
        self.delegate = delegate
    }
}

extension AccountsFormViewDelegate: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectAccount(at: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
