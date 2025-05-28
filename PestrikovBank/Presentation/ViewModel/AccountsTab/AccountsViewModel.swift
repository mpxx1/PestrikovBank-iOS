//
//  AccountsViewModel.swift
//  PestrikovBank
//
//  Created by m on 19.05.2025.
//

import Combine
import Dispatch
import Foundation

public enum UserAccountsLoadingState {
    case none
    case loadingUser
    case loadingAccounts
    case failed(Error)
    case userLoadedNoAccounts
    case userLoadedNoCards
    case accountsLoaded([Account])
}

public enum CardsLoadingState {
    case none
    case loading
    case failed(Error)
    case cardsLoaded([Card])
}

// todo AccountCardLoadingState

public enum SelectedAccount {
    case none
    case selected(Account)
}

public enum AccountsNavigateTo {
    case selectedAccount
}

public protocol AccountsViewModel {
    var accountsLoadingState: UserAccountsLoadingState { get }
    var cardsLoadingState: CardsLoadingState { get }
    var selectedAccount: SelectedAccount { get }
    
    var accountsLoadingStatePublisher: Published<UserAccountsLoadingState>.Publisher { get }
    var cardsLoadingStatePublisher: Published<CardsLoadingState>.Publisher { get }
    var selectedAccountPublisher: Published<SelectedAccount>.Publisher { get }
    
    var onAccountTapped: PassthroughSubject<AccountsNavigateTo, Never> { get }
    
    func fetchAccounts()
    func fetchCards()
    func selectAccount(at index: Int)
}
