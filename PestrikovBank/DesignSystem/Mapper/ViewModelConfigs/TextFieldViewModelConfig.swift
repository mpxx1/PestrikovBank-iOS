//
//  TextFieldViewModelConfig.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

struct TextFieldViewModelConfig: Codable {
    let id: String
    let placeholder: String
    let textColor: String
    let font: SystemFontConfig
    let keyboardType: KeyboardType
    let isSecureTextEntry: Bool
    let autocapitalizationType: TextAutocapitalizationType
    let closureKey: ClosureKey
    let layout: [LayoutConfig]
}

enum KeyboardType: String, Codable {
    case base
    case numberPad
}

enum TextAutocapitalizationType: String, Codable {
    case none
    case words
    case sentences
    case allCharacters
}
