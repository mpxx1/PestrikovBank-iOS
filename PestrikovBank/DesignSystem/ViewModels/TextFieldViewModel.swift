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
    let layout: [LayoutConfig]
    
    let placeholder: String
    let text: String? = nil
    let textColor: UIColor
    let font: UIFont
    let keyboardType: UIKeyboardType
    let isSecureTextEntry: Bool
    let autocapitalizationType: UITextAutocapitalizationType
    let onEditingChanged: ((String) -> Void)?
    
    init(
        id: String,
        layout: [LayoutConfig],
        placeholder: String = "",
        textColor: UIColor = .black,
        font: UIFont = .systemFont(ofSize: 16),
        keyboardType: UIKeyboardType = .default,
        isSecureTextEntry: Bool = false,
        autocapitalizationType: UITextAutocapitalizationType = .sentences,
        onEditChanged: ((String) -> Void)? = nil
    ) {
        self.id = id
        self.layout = layout
        
        self.placeholder = placeholder
        self.textColor = textColor
        self.font = font
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.autocapitalizationType = autocapitalizationType
        self.onEditingChanged = onEditChanged
    }
}
