//
//  MainScreenViewController.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

class AccountsViewController: UIViewController {
    private let viewModel: AccountsViewModel
    private var form: AccountsFormView!
    private var cancellables = Set<AnyCancellable>()
    
    public var onAccountTapped: (() -> Void)?

    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccountsFormView()
        bindViewModel()
    }

    private func setupAccountsFormView() {
        form = AccountsFormView(frame: view.bounds, viewModel: viewModel)
        
        form.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(form)

        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: view.topAnchor),
            form.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            form.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            form.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onAccountTapped
            .receive(on: DispatchQueue.main)
            .sink { [weak self] navigation in
                guard let self = self else { return }
                
                switch navigation {
                case .selectedAccount:
                    self.onAccountTapped?()
                }
            }
            .store(in: &cancellables)
    }
}
