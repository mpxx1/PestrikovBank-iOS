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
    let onDarkTextColor: UIColor
    let onLightTextColor: UIColor
}

//public struct ButtonComponent: Component {
//    public var id: String
////    public var view: UIView { buttonView }
//    private var buttonView: UIButton
//    private var cancellables = Set<AnyCancellable>()
//    private var config: ButtonComponentConfig
//    
//    init(
//        config: ButtonComponentConfig
//    ) {
//        self.id = config.id
//        
//        let btn = UIButton(type: config.buttonType)
//        btn.setTitle(config.title, for: config.uiControlState)
//        btn.isEnabled = config.isEnabled
//        
//        btn.titleLabel!.font = UIFont(name: config.fontName, size: config.fontSize)
//        buttonView = btn
//        self.config = config
//    }
//    
//    public func bind(to viewModel: AnyObject, of type: ViewModelType) {
//        switch type {
//        case .accounts:
//            break   // unimplemented
//        case .userDetails:
//            break   // unimplemented
//        }
//    }
//    
//    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
//        setupConstraintsDefault(self, in: container, preset: preset)
//    }
//}
