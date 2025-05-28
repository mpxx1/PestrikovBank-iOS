//
//  MainScreenViewController.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

final class AccountsViewController: UIViewController {
    private let viewModel: AccountsViewModel
    private var form: AccountsFormView!
    private var cancellables = Set<AnyCancellable>()
    
    var onAccountTapped: (() -> Void)?

    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        form = AccountsFormView(eventHandler: self)
        view = form
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetchAccounts()
    }

    private func bindViewModel() {
        viewModel
            .selectedAccountPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] account in
                switch account {
                case .none:
                    break
                case .selected(_):
                    self?.onAccountTapped?()
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .accountsLoadingStatePublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.form.setLoading(false)
                        print("Accounts loading failed with error: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] state in
                    switch state {
                    case .loadingAccounts, .loadingUser:
                        self?.form.setLoading(true)
                    case .accountsLoaded(let accounts):
                        self?.form.setLoading(false)
                        self?.form.update(with: accounts)
                    case .failed(let error):
                        self?.form.setLoading(false)
                        print("Accounts state failure: \(error.localizedDescription)")
                    default:
                        self?.form.setLoading(false)
                    }
                }
            )
            .store(in: &cancellables)
    }
}

extension AccountsViewController: AccountsFormViewEventHandling {
    func didTapUserDetails() {
        // unimplemented
    }

    func didSelectAccount(at index: Int) {
        viewModel.selectAccount(at: index)
    }
}
