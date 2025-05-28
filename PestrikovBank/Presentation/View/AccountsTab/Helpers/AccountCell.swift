//
//  AccountCell.swift
//  PestrikovBank
//
//  Created by m on 25.05.2025.
//

import UIKit

final class AccountCell: UITableViewCell {
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

    func configure(with account: Account) {
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
