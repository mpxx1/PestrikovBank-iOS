//
//  ButtonComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

public struct ButtonComponentConfig {
    let id: String
    let title: String
    let buttonType: UIButton.ButtonType
    let uiControlState: UIControl.State
    let isEnabled: Bool
    let fontName: String
    let fontSize: CGFloat
    let color: ColorVariant
}

public class ButtonComponent: UIButton, Component {
    public var id: String
    
    init(
        config: ButtonComponentConfig
    ) {
        self.id = config.id
        super.init(frame: .zero)
        
        self.setTitle(config.title, for: config.uiControlState)
        self.isEnabled = config.isEnabled
        
        self.titleLabel!.font = UIFont(name: config.fontName, size: config.fontSize)
        
        switch config.color {
        case .system: break
        case .systemRed: tintColor = .systemRed
        case .systemBlue: tintColor = .systemBlue
        case .systemGreen: tintColor = .systemGreen
        case .systemOrange: tintColor = .systemOrange
        case .systemPurple: tintColor = .systemPurple
        case .single(let color): tintColor = color
        case .dynamic(onLight: let onLight, onDark: let onDark):
            tintColor = dynColor(onLight: onLight, onDark: onDark)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(to viewModel: ViewModelType) {
        switch viewModel {
        case .accountsViewModel(_):
            break
        }
    }
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
}
