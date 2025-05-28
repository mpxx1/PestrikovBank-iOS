//
//  AccountsViewModelImpl.swift
//  PestrikovBank
//
//  Created by m on 25.05.2025.
//

import UIKit
import Combine

public class AccountsViewModelImpl: AccountsViewModel {
    
    public var accountsLoadingStatePublisher: Published<UserAccountsLoadingState>.Publisher { $accountsLoadingState }
    public var cardsLoadingStatePublisher: Published<CardsLoadingState>.Publisher { $cardsLoadingState }
    public var selectedAccountPublisher: Published<SelectedAccount>.Publisher { $selectedAccount }
    
    private var fetchAccountsUseCase: FetchAccountsUseCase
    private var fetchCardsUseCase: FetchCardsUseCase
    public var cancellables = Set<AnyCancellable>()
    private var accounts: [Account] = []
    
    @Published public var accountsLoadingState: UserAccountsLoadingState = .none
    @Published public var cardsLoadingState: CardsLoadingState = .none
    @Published public var selectedAccount: SelectedAccount = .none
    
    public var onAccountTapped: PassthroughSubject<AccountsNavigateTo, Never> = .init()
//    public var selectedAccountPublisher = PassthroughSubject<SelectedAccount, Never>()
//    public var accountsLoadingStatePublisher = PassthroughSubject<UserAccountsLoadingState, Error>()
    
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
                        self?.accounts = accounts.accounts
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
    
    public func selectAccount(at index: Int) {
        guard accounts.indices.contains(index) else { return }
        let account = accounts[index]
        selectedAccount = .selected(account)
        onAccountTapped.send(.selectedAccount)
    }
    
//    public func loadCardImage() {} // todo rx: url -> UIImage
    
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
