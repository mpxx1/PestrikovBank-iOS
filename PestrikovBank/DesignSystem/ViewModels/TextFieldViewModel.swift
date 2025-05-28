//
//  TextFieldViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

struct TextFieldViewModel: PBViewModel {
    let id: String
    let type: ComponentType = .textField
    let constraints: [NSLayoutConstraint]
    
    let placeholder: String
    let text: String?
    let textColor: UIColor
    let font: UIFont
    let keyboardType: UIKeyboardType
    let returnKeyType: UIReturnKeyType
    let isSecureTextEntry: Bool
    let autocapitalizationType: UITextAutocapitalizationType
    let onEditingChanged: ((String) -> Void)?
    
    init(
        id: String,
        constraints: [NSLayoutConstraint],
        placeholder: String = "",
        text: String? = nil,
        textColor: UIColor = .black,
        font: UIFont = .systemFont(ofSize: 16),
        keyboardType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        isSecureTextEntry: Bool = false,
        autocapitalizationType: UITextAutocapitalizationType = .sentences,
        onEditChanged: ((String) -> Void)? = nil
    ) {
        self.id = id
        self.constraints = constraints
        
        self.placeholder = placeholder
        self.text = text
        self.textColor = textColor
        self.font = font
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.isSecureTextEntry = isSecureTextEntry
        self.autocapitalizationType = autocapitalizationType
        self.onEditingChanged = onEditChanged
    }
}
