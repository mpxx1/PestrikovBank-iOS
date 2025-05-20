//
//  TextFieldComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

public struct TextFieldComponentConfig {
    let identifier: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let autocapitalizationType: UITextAutocapitalizationType
    let isSecureTextEntry: Bool
}

public struct TextFieldComponent: Component {
    public var identifier: String
    public var view: UIView { textFieldView }
    private var textFieldView: UITextField
    private var cancellables = Set<AnyCancellable>()
    
    init(
        config: TextFieldComponentConfig
    ) {
        self.identifier = config.identifier
        
        let textField = UITextField()
        textField.placeholder = config.placeholder
        textField.keyboardType = config.keyboardType
        textField.font = .systemFont(ofSize: config.fontSize, weight: config.fontWeight)
        textField.autocapitalizationType = config.autocapitalizationType
        textField.isSecureTextEntry = config.isSecureTextEntry
        textFieldView = textField
    }
    
    public mutating func bind(to viewModel: AnyObject, of type: ViewModelType) {
        switch type {
        case .login:
            guard let viewModel = viewModel as? LoginViewModel else { return }
            
            switch identifier {
            case "phone_number_text_field":
                textFieldView
                    .publisher(for: .editingChanged)
                    .compactMap { ($0 as! UITextField).text }
                    .assign(to: \.phoneNumber, on: viewModel)
                    .store(in: &cancellables)
            
            case "password_text_field":
                textFieldView
                    .publisher(for: .editingChanged)
                    .compactMap { ($0 as! UITextField).text }
                    .assign(to: \.phoneNumber, on: viewModel)
                    .store(in: &cancellables)
                
                viewModel
                    .$password
                    .receive(on: DispatchQueue.main)
                    .sink { [self] newPassword in
                        self.textFieldView.text = newPassword
                    }
                    .store(in: &cancellables)
                
            default:
                fatalError("Unknown identifier \(identifier)")
            }
            
        case .signUp:
            guard let viewModel = viewModel as? SignUpViewModel else { return }
            
            switch identifier {
            case "phone_number_text_field":
                textFieldView
                    .publisher(for: .editingChanged)
                    .compactMap { ($0 as! UITextField).text }
                    .assign(to: \.phoneNumber, on: viewModel)
                    .store(in: &cancellables)
                
            case "password_text_field":
                textFieldView
                    .publisher(for: .editingChanged)
                    .compactMap { ($0 as! UITextField).text }
                    .assign(to: \.phoneNumber, on: viewModel)
                    .store(in: &cancellables)
                
//            case "confirm_password_text_field":
                
            default:
                fatalError("Unknown identifier \(identifier)")
            }
        }
    }
    
    public func switchTheme() {}
}
