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
    let color: ColorVariant
}

public class ActivityIndicatorComponent: UIActivityIndicatorView, Component {
    public var id: String
    
    init(
        config: ActivityIndicatorComponentConfig
    ) {
        self.id = config.id
        super.init(frame: .zero)
        
        switch config.color {
        case .system: break
        case .systemRed: color = .systemRed
        case .systemBlue: color = .systemBlue
        case .systemGreen: color = .systemGreen
        case .systemOrange: color = .systemOrange
        case .systemPurple: color = .systemPurple
        case .single(let color): self.color = color
        case .dynamic(onLight: let onLight, onDark: let onDark):
            color = dynColor(onLight: onLight, onDark: onDark)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(to viewModel: ViewModelType) {}
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
}
