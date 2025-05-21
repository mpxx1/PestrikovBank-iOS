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
    case accountsLoaded([AccountImpl])
}

public enum CardsLoadingState {
    case none
    case loading
    case failed(Error)
    case cardsLoaded([CardImpl])
}

// todo AccountCardLoadingState

public enum SelectedAccount {
    case none
    case selected(AccountImpl)
}

public enum AccountsNavigateTo {
    case selectedAccount
}

public class AccountsViewModel {
    private var fetchAccountsUseCase: FetchAccountsUseCase
    private var fetchCardsUseCase: FetchCardsUseCase
    public var cancellables = Set<AnyCancellable>()
    
    @Published public var accountsLoadingState: UserAccountsLoadingState = .none
    @Published public var cardsLoadingState: CardsLoadingState = .none
    @Published public var selectedAccount: SelectedAccount = .none
    
    var onAccountTapped = PassthroughSubject<AccountsNavigateTo, Never>()
    
    init(
        fetchAccountsUseCase: FetchAccountsUseCase,
        fetchCardsUseCase: FetchCardsUseCase
    ) {
        self.fetchAccountsUseCase = fetchAccountsUseCase
        self.fetchCardsUseCase = fetchCardsUseCase
    }
    
    public func fetchAccounts() {
        accountsLoadingState = .loadingUser
        
        getUserId(for: .accounts)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.accountsLoadingState = .failed(error)
                    print("User ID fetch failed: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] userId in
                guard let self = self else { return }
                self.accountsLoadingState = .loadingAccounts
                self
                    .fetchAccountsUseCase
                    .execute(user: userId)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] completion in
                        switch completion {
                        case .failure(let error):
                            self?.accountsLoadingState = .failed(error)
                            print("Accounts fetch failed: \(error)")
                        case .finished:
                            break
                        }
                    } receiveValue: { [weak self] accounts in
                        self?.accountsLoadingState = .accountsLoaded(accounts.accounts)
                    }
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)
    }
    
    public func fetchCards() {
        cardsLoadingState = .loading
        
        getUserId(for: .cards)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.accountsLoadingState = .failed(error)
                    self?.cardsLoadingState = .failed(error)
                    print("User ID fetch failed: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] userId in
                guard let self = self else { return }
                self
                    .fetchCardsUseCase
                    .execute(user: userId)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] completion in
                        switch completion {
                        case .failure(let error):
                            self?.cardsLoadingState = .failed(error)
                            print("Cards fetch failed: \(error)")
                        case .finished:
                            break
                        }
                    } receiveValue: { [weak self] cards in
                        self?.cardsLoadingState = .cardsLoaded(cards.cards)
                    }
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)
    }
    
    public func loadCardImage() {} // todo rx: url -> UIImage
    
    private enum Caller {
        case accounts
        case cards
    }
    
    private func getUserId(for: Caller) -> AnyPublisher<UserId, Error> {
        accountsLoadingState = .loadingUser
        
        return SessionManagerImpl
            .shared
            .currentUserPublisher
            .setFailureType(to: Error.self)
            .filter { authState in
                if case .loggedIn = authState {
                    return true
                }
                return false
            }
            .tryMap { authState in
                if case .loggedIn(let user) = authState {
                    
                    if case .cards = `for` {
                        self.accountsLoadingState = .userLoadedNoCards
                    } else if case .accounts = `for` {
                        self.accountsLoadingState = .userLoadedNoAccounts
                    }
                    
                    return UserIdImpl(id: user.id)
                }
                let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected state"])
                self.accountsLoadingState = .failed(err)
                throw err
            }
            .eraseToAnyPublisher()
    }
}
