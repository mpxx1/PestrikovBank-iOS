//
//  TitleComponent.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit

public struct TitleComponentConfig {
    let identifier: String
    let text: String
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
}

public struct TitleComponent: Component {
    public var identifier: String
    public var view: UIView
    
    init(config: TitleComponentConfig) {
        self.identifier = config.identifier
        
        let label = UILabel()
        label.text = config.text
        
        label.font = .systemFont(ofSize: config.fontSize, weight: config.fontWeight)
        view = label
    }
    
    public func bind(to viewModel: AnyObject, of type: ViewModelType) {}
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
}
