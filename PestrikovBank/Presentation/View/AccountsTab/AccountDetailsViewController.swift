//
//  AccountAboutViewControler.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit
import Combine

public class AccountDetailsViewController: UIViewController {
    private let viewModel: AccountsViewModel
    private var form: AccountDetailsFormView!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.fetchCards()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        form = AccountDetailsFormView(frame: .zero)
        view.addSubview(form)
        
        form.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: view.topAnchor),
            form.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            form.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            form.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel
            .selectedAccountPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedAccount in
                switch selectedAccount {
                case .none:
                    self?.form.isHidden = true
                case .selected(let account):
                    self?.form.isHidden = false
                    self?.form.configure(with: account)
                }
            }
            .store(in: &cancellables)
    }
}
