//
//  DSAcountDetailsFormView.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit
import Combine

public class DSAccountDetailsFormView: UIView {
    private var viewModel: AccountsViewModel
    private var components = [any Component]()
    private var constraintPresets = [String:ConstraintPreset]()
    
    init(
        frame: CGRect,
        viewModel: AccountsViewModel,
        screenTitleComponintConfig: LabelComponentConfig,
        cardImageConfig: ImageComponentConfig,
        accountIdLabelConfig: LabelComponentConfig,
        accountIdConfig: LabelComponentConfig,
        amountLabelConfig: LabelComponentConfig,
        amountConfig: LabelComponentConfig,
        accountTypeLabelConfig: LabelComponentConfig,
        accountTypeConfig: LabelComponentConfig,
        createdAtLabelConfig: LabelComponentConfig,
        createdAtConfig: LabelComponentConfig
    ) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        components.append(LabelComponent(config: screenTitleComponintConfig))
        components.append(ImageComponent(config: cardImageConfig))
        components.append(LabelComponent(config: accountIdLabelConfig))
        components.append(LabelComponent(config: accountIdConfig))
        components.append(LabelComponent(config: amountLabelConfig))
        components.append(LabelComponent(config: amountConfig))
        components.append(LabelComponent(config: accountTypeLabelConfig))
        components.append(LabelComponent(config: accountTypeConfig))
        components.append(LabelComponent(config: createdAtLabelConfig))
        components.append(LabelComponent(config: createdAtConfig))
        
        setupView()
        bindViewModel()
        viewModel.fetchCards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        components.forEach {
            addSubview($0)
        }
        
        constraintPresets[components[0].id] = .topAttached(insets: UIEdgeInsets(top: 2, left: 20, bottom: -20, right: 0))
        constraintPresets[components[1].id] = .fixedSizeBelow(components[0], insets: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0), size: CGSize(width: 300, height: 180))
        constraintPresets[components[2].id] = .below(components[1], insets: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: -20))
        constraintPresets[components[3].id] = .below(components[2], insets: UIEdgeInsets(top: 4, left: 20, bottom: 0, right: -20))
        constraintPresets[components[4].id] = .below(components[3], insets: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: -20))
        constraintPresets[components[5].id] = .below(components[4], insets: UIEdgeInsets(top: 4, left: 20, bottom: 0, right: -20))
        constraintPresets[components[6].id] = .below(components[5], insets: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: -20))
        constraintPresets[components[7].id] = .below(components[6], insets: UIEdgeInsets(top: 4, left: 20, bottom: 0, right: -20))
        constraintPresets[components[8].id] = .below(components[7], insets: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: -20))
        constraintPresets[components[9].id] = .below(components[8], insets: UIEdgeInsets(top: 4, left: 20, bottom: 0, right: -20))
        
        
        components.forEach {
            $0.setupConstraints(in: self, preset: constraintPresets[$0.id]!)
        }
    }
    
    private func bindViewModel() {
        components.forEach {
            $0.bind(to: .accountsViewModel(viewModel))
        }
    }
}
