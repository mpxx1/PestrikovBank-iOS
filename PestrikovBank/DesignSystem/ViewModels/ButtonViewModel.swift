//
//  ButtonViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit
import Combine

struct ButtonViewModel: PBViewModel {
    let id: String
    let type: ComponentType = .button
    let constraints: [NSLayoutConstraint]
    
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    let cornerRadius: CGFloat
    let font: UIFont
    let isEnabled: Bool
    let tapAction: (() -> Void)?
        
    init(
        id: String,
        constraints: [NSLayoutConstraint],
        title: String,
        titleColor: UIColor = .white,
        backgroundColor: UIColor = .systemRed,
        cornerRadius: CGFloat = 8,
        font: UIFont = .systemFont(ofSize: 16, weight: .medium),
        isEnabled: Bool = true,
        tapAction: (() -> Void)? = nil
    ) {
        self.id = id
        self.constraints = constraints
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.font = font
        self.isEnabled = isEnabled
        self.tapAction = tapAction
    }
}
