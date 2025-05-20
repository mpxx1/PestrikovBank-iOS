//
//  ButtonComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

public struct ButtonComponentConfig {
    let identifier: String
    let title: String
    let buttonType: UIButton.ButtonType
    let uiControlState: UIControl.State
    let isEnabled: Bool
    let fontName: String
    let fontSize: CGFloat
    let onDarkTextColor: UIColor
    let onLightTextColor: UIColor
}

public struct ButtonComponent: Component {
    public var identifier: String
    public var view: UIView { buttonView }
    private var buttonView: UIButton
    private var cancellables = Set<AnyCancellable>()
    private var config: ButtonComponentConfig
    
    init(
        config: ButtonComponentConfig
    ) {
        self.identifier = config.identifier
        
        let btn = UIButton(type: config.buttonType)
        btn.setTitle(config.title, for: config.uiControlState)
        btn.isEnabled = config.isEnabled
        
        btn.titleLabel!.font = UIFont(name: config.fontName, size: config.fontSize)
        buttonView = btn
        self.config = config
    }
    
    public mutating func bind(to viewModel: AnyObject, of type: ViewModelType) {
        switch type {
        case .login:
            guard let viewModel = viewModel as? LoginViewModel else { return }
            
            switch identifier {
            case "login_button":
                buttonView
                    .publisher(for: .touchUpInside)
                    .sink { _ in
                        viewModel.submitLogin()
                    }
                    .store(in: &cancellables)
                
            case "signup_button":
                buttonView
                    .publisher(for: .touchUpInside)
                    .sink { _ in
                        viewModel.didTapSignUpButton()
                    }
                    .store(in: &cancellables)
                
            default:
                fatalError("Unknown identifier \(identifier)")
            }
            
        case .signUp:
            guard let viewModel = viewModel as? SignUpViewModel else { return }
            
            switch identifier {
            case "signup_button":
                buttonView
                    .publisher(for: .touchUpInside)
                    .sink { _ in
                        viewModel.submitSignUp()
                    }
                    .store(in: &cancellables)
                
            default:
                fatalError("Unknown identifier \(identifier)")
            }
        case .accounts:
            break   // unimplemented
        case .userDetails:
            break   // unimplemented
        }
    }
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
}
