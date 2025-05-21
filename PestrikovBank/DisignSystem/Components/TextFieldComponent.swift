//
//  TextFieldComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

public struct TextFieldComponentConfig {
    let id: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let autocapitalizationType: UITextAutocapitalizationType
    let isSecureTextEntry: Bool
}

public class TextFieldComponent: UITextField, Component {
    public var id: String
    
    init(
        config: TextFieldComponentConfig
    ) {
        self.id = config.id
        super.init(frame: .zero)
        
        placeholder = config.placeholder
        keyboardType = config.keyboardType
        font = .systemFont(ofSize: config.fontSize, weight: config.fontWeight)
        autocapitalizationType = config.autocapitalizationType
        isSecureTextEntry = config.isSecureTextEntry
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(to viewModel: ViewModelType) {
        
    }
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
}
