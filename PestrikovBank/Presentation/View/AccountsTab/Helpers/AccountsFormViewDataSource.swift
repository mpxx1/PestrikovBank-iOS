//
//  AccountsFormViewDataSource.swift
//  PestrikovBank
//
//  Created by m on 25.05.2025.
//

import UIKit

final class AccountsFormViewDataSource: NSObject {
    private var displayItems = [Account]()
    
    func update(with items: [Account]) {
        self.displayItems = items
    }
}

extension AccountsFormViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        cell.configure(with: displayItems[indexPath.row])
        return cell
    }
}
