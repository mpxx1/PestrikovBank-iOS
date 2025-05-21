//
//  ActivityIndicatorComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit
import Combine

public struct ActivityIndicatorComponentConfig {
    let id: String
    let style: UIActivityIndicatorView.Style
    let onDarkColor: UIColor
    let onLightColor: UIColor
}

//public class ActivityIndicatorComponent: Component {
//    public var id: String
//    public var view: UIView { indicatorView }
//    private var indicatorView: UIActivityIndicatorView
//    private var cancellables = Set<AnyCancellable>()
//    private var config: ActivityIndicatorComponentConfig
//    
//    init(
//        config: ActivityIndicatorComponentConfig
//    ) {
//        self.id = config.id
//        
//        let indicator = UIActivityIndicatorView(style: config.style)
//        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
//            indicator.tintColor = config.onDarkColor
//        } else {
//            indicator.color = config.onLightColor
//        }
//        self.indicatorView = indicator
//        self.config = config
//    }
//    
//    public func bind(to viewModel: AnyObject, of type: ViewModelType) {
////        switch type {
////        case .login:
////            
////        case .signUp:
////            
////        }
//    }
//    
//    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
//        setupConstraintsDefault(self, in: container, preset: preset)
//    }
//}
