//
//  AboutAccountFormView.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit
import Combine

public class AccountDetailsFormView: UIView {
    private var viewModel: AccountsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public var accountIdLabel: UILabel = {
        let label = UILabel()
        label.text = "Account ID"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var accountId: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var amount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var type: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "Created"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var created: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .white : #colorLiteral(red: 0.5440881252, green: 0, blue: 0, alpha: 1)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init(frame: CGRect, viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
        bindViewModel()
        viewModel.fetchCards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(title)
        addSubview(cardImageView)
        addSubview(accountIdLabel)
        addSubview(accountId)
        addSubview(amountLabel)
        addSubview(amount)
        addSubview(typeLabel)
        addSubview(type)
        addSubview(createdAtLabel)
        addSubview(created)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            // Title
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Card image
            cardImageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardImageView.widthAnchor.constraint(equalToConstant: 300), // Fixed width
            cardImageView.heightAnchor.constraint(equalToConstant: 180), // Fixed height (5:3 aspect ratio)
            
            // Account ID
            accountIdLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 30),
            accountIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountIdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            accountId.topAnchor.constraint(equalTo: accountIdLabel.bottomAnchor, constant: 4),
            accountId.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountId.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Amount
            amountLabel.topAnchor.constraint(equalTo: accountId.bottomAnchor, constant: 30),
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            amount.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
            amount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            amount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Type
            typeLabel.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: 30),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            type.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            type.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            type.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Created
            createdAtLabel.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 30),
            createdAtLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            createdAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            created.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 4),
            created.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            created.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Activity indicator
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel
            .$selectedAccount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedAccount in
                guard let self = self else { return }
                
                switch selectedAccount {
                case .none:
                    self.activityIndicator.startAnimating()
                    self.cardImageView.isHidden = true
                    self.accountId.isHidden = true
                    self.amount.isHidden = true
                    self.type.isHidden = true
                    self.created.isHidden = true
                    
                    let emptyLabel = UILabel()
                    emptyLabel.textAlignment = .center
                    emptyLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.addSubview(emptyLabel)
                    NSLayoutConstraint.activate([
                        emptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                        emptyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                    ])
                    
                case .selected(let account):
                    self.activityIndicator.stopAnimating()
                    self.cardImageView.isHidden = false
                    self.accountId.isHidden = false
                    self.amount.isHidden = false
                    self.type.isHidden = false
                    self.created.isHidden = false
                    
                    self.accountId.text = "ID: \(account.id)"
                    self.amount.text = "\(account.amount) £"
                    self.type.text = account.variant.rawValue.capitalized
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    self.created.text = formatter.string(from: account.createdAt)
                    
                    self.setPlaceholderCardImage(for: account)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setPlaceholderCardImage(for account: AccountImpl) {
        let lastFourDigits = String(format: "%04d", account.id)
        let color = getCardColor(for: account.variant)
        let placeholderImage = createColoredImage(size: CGSize(width: 200, height: 120), color: color, digits: lastFourDigits)
        cardImageView.image = placeholderImage
    }
    
    private func createColoredImage(size: CGSize, color: UIColor, digits: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .bold),
                .foregroundColor: UIColor.white
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
