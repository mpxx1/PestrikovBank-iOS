//
//  TitleComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit

public struct LabelComponentConfig {
    let id: String
    let text: String
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let color: ColorVariant
}

public class LabelComponent: UILabel, Component {
    public var id: String
    
    init(config: LabelComponentConfig) {
        self.id = config.id
        super.init(frame: .zero)
        
        text = config.text
        
        font = .systemFont(ofSize: config.fontSize, weight: config.fontWeight)
        
        switch config.color {
        case .system: break
        case .systemRed: textColor = .systemRed
        case .systemBlue: textColor = .systemBlue
        case .systemGreen: textColor = .systemGreen
        case .systemOrange: textColor = .systemOrange
        case .systemPurple: textColor = .systemPurple
        case .single(let color): textColor = color
        case .dynamic(onLight: let onLight, onDark: let onDark):
            textColor = dynColor(onLight: onLight, onDark: onDark)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(to viewModel: ViewModelType) {
        switch viewModel {
        case .accountsViewModel(let viewModel):
            viewModel
                .$selectedAccount
                .receive(on: DispatchQueue.main)
                .sink { [weak self] selectedAccount in
                    guard let self = self else { return }
                    
                    switch selectedAccount {
                    case .none:
                        self.isHidden = true
                        
                    case .selected(let account):
                        self.isHidden = false
                        
                        switch self.id {
                        case "account_id":
                            self.text = "ID: \(account.id)"
                        case "amount":
                            self.text = "\(account.amount) £"
                        case "account_type":
                            self.text = account.variant.rawValue.capitalized
                        case "created_at":
                            let formatter = DateFormatter()
                            formatter.dateStyle = .medium
                            self.text = formatter.string(from: account.createdAt)
                        default:
                            break
                        }
                    }
                }
                .store(in: &viewModel.cancellables)
        }
    }
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
}
