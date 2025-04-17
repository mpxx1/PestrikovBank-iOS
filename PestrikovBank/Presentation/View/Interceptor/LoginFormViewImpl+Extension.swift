//
//  LoginFormViewImpl.swift
//  PestrikovBank
//
//  Created by m on 17.04.2025.
//

import UIKit

final class LoginFormViewImpl: UIView {
    
    public let title: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome!"
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()
    
    public let phoneField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone"
        tf.keyboardType = .phonePad
        tf.font = .systemFont(ofSize: 22)
        return tf
    }()

    public let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = .systemFont(ofSize: 22)
        return tf
    }()

    public let loginButton: UIButton = {
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
    
    public let signUpButton: UIButton = {
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
    
    private let maxNumberCount = 11
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            title,
            phoneField,
            passwordField,
            loginButton,
            signUpButton
        ])
        sv.axis = .vertical
        sv.spacing = 30
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError("Not supported") }
    
    public func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        
        return "+" + number
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }

    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            updateButtonColors()
        }
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

extension LoginFormViewImpl: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let fullString = (textField.text ?? "") + string
        let formatted = format(
            phoneNumber: fullString,
            shouldRemoveLastDigit: range.length == 1
        )
        
        textField.text = formatted
        textField.sendActions(for: .editingChanged)
        
        return false
    }
}
