//
//  AccountsViewForm.swift
//  PestrikovBank
//
//  Created by m on 19.05.2025.
//

import UIKit
import Combine

public class AccountsFormView: UIView {
    private var viewModel: AccountsViewModel
    private var cancellables = Set<AnyCancellable>()
    private var accounts: [AccountImpl] = []

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
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            indicator.color = .white
        } else {
            indicator.color = #colorLiteral(red: 0.5440881252, green: 0, blue: 0, alpha: 1)
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    init(frame: CGRect, viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
        bindViewModel()
        viewModel.fetchAccounts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(title)
        addSubview(tableView)
        addSubview(activityIndicator)

        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func bindViewModel() {
        title
            .publisher(for: .touchUpInside)
            .sink { _ in
                print("About me")
            }
            .store(in: &cancellables)
        
        viewModel
            .$accountsLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loadingUser, .loadingAccounts:
                    self?.activityIndicator.startAnimating()
                    self?.tableView.isHidden = true
                case .userLoadedNoAccounts:
                    self?.activityIndicator.startAnimating()
                    self?.tableView.isHidden = true
                case .userLoadedNoCards:
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.isHidden = false
                case .accountsLoaded(let accounts):
                    self?.accounts = accounts
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                case .failed(let error):
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.isHidden = true
                    print("Loading error: \(error.localizedDescription)")
                case .none:
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.isHidden = true
                }
            }
            .store(in: &cancellables)
    }
}

extension AccountsFormView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        return cell
    }
}

extension AccountsFormView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let account = accounts[indexPath.row]
        viewModel.selectedAccount = .selected(account)
        viewModel.onAccountTapped.send(.selectedAccount)
    }
}

private class AccountCell: UITableViewCell {
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let amountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)
        
        cardImageView.layer.cornerRadius = 6
        cardImageView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cardImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardImageView.widthAnchor.constraint(equalToConstant: 60),
            cardImageView.heightAnchor.constraint(equalToConstant: 40),

            amountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            amountLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 22),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3),
            titleLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with account: AccountImpl) {
        let color = getCardColor(for: account.variant)
        let lastFourDigits = String(format: "%04d", account.id)
        let image = createColoredImage(size: CGSize(width: 60, height: 40), color: color, digits: lastFourDigits)
        cardImageView.image = image

        titleLabel.text = account.variant.rawValue
        amountLabel.text = "\(account.amount) £"
    }

    private func createColoredImage(size: CGSize, color: UIColor, digits: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12, weight: .bold),
            ]
            let attributedString = NSAttributedString(string: digits, attributes: attributes)

            let textSize = attributedString.size()
            let textRect = CGRect(
                x: (size.width - textSize.width) / 2,
                y: (size.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )

            attributedString.draw(in: textRect)
        }
        return image
    }

    private func getCardColor(for variant: AccountVariant) -> UIColor {
        switch variant {
        case .base: return .systemRed
        case .business: return .systemRed
        case .credit: return .systemPurple
        case .debit: return .systemBlue
        case .saving: return .systemOrange
        }
    }
}
