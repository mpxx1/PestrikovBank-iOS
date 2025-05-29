//
//  AccountsViewForm.swift
//  PestrikovBank
//
//  Created by m on 19.05.2025.
//

import UIKit
import Combine

public final class AccountsFormView: UIView {
    private let tableViewDelegate: AccountsFormViewDelegate
    private let tableViewDataSource: AccountsFormViewDataSource
    private weak var eventHandler: AccountsFormViewEventHandling?
    private var cancellables = Set<AnyCancellable>()
    
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    public var title: UIButton = {
        let btn = UIButton()
        var name = "Hello ›"
        switch SessionManagerImpl.shared.currentUserPublisher.value {
        case .loggedIn(let user):
            switch user.firstName {
            case .none:
                break
            case .some(let firstName):
                name = "Hello, \(firstName) ›"
            }
        default:
            break
        }
        btn.setTitle(name, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.setTitleColor(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .white
            default:
                return .black
            }
        }, for: .normal)

        return btn
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
        return table
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .white
            default:
                return #colorLiteral(red: 0.5440881252, green: 0, blue: 0, alpha: 1)
            }
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(eventHandler: AccountsFormViewEventHandling) {
        self.eventHandler = eventHandler
        self.tableViewDelegate = AccountsFormViewDelegate(delegate: eventHandler)
        self.tableViewDataSource = AccountsFormViewDataSource()
        super.init(frame: .zero)
        setupView()
    }
    
    public func setLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    public func update(with accounts: [Account]) {
        tableViewDataSource.update(with: accounts)
        tableView.reloadData()
    }
    
    private func setupView() {
        addSubview(title)
        addSubview(tableView)
        addSubview(activityIndicator)
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        title
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.eventHandler?.didTapUserDetails()
            }
            .store(in: &cancellables)
    }
}
