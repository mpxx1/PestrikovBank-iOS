//
//  LoginFormViewImpl.swift
//  PestrikovBank
//
//  Created by m on 17.04.2025.
//

import UIKit

final class LoginFormView: UIView {
    
    public var phoneNumberFormatting: (String, Bool) -> String
    
    public var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "Login"
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()
    
    public var phoneField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone"
        tf.keyboardType = .phonePad
        tf.font = .systemFont(ofSize: 22)
        return tf
    }()

    public var passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = .systemFont(ofSize: 22)
        return tf
    }()

    public var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.isEnabled = false
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            btn.tintColor = .white
        } else {
            btn.tintColor = #colorLiteral(red: 0.5440881252, green: 0, blue: 0, alpha: 1)
        }
        btn.titleLabel!.font = UIFont(name: "Helvetica", size: 18)
        return btn
    }()
    
    public var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            btn.tintColor = .white
        } else {
            btn.tintColor = #colorLiteral(red: 0.5440881252, green: 0, blue: 0, alpha: 1)
        }
        btn.titleLabel!.font = UIFont(name: "Helvetica", size: 18)
        return btn
    }()

    private var stackView: UIStackView!
    
    init(frame: CGRect, phoneNumberFormatting: @escaping (String, Bool) -> String) {
        self.phoneNumberFormatting = phoneNumberFormatting
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError("Not supported") }
    
    public override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            updateButtonColors()
        }
    }

    private func setupLayout() {
        stackView = UIStackView(arrangedSubviews: [
            title,
            phoneField,
            passwordField,
            loginButton,
            signUpButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 30
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }

    private func updateButtonColors() {
        let tint: UIColor
        if traitCollection.userInterfaceStyle == .dark {
            tint = .white
        } else {
            tint = #colorLiteral(red: 0.5440881252, green: 0, blue: 0, alpha: 1)
        }

        [loginButton, signUpButton].forEach {
            $0.tintColor = tint
        }
    }
}

extension LoginFormView: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let fullString = (textField.text ?? "") + string
        let formatted = phoneNumberFormatting(
            fullString,
            range.length == 1
        )
        
        textField.text = formatted
        textField.sendActions(for: .editingChanged)
        
        return false
    }
}
