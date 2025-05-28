//
//  LabelViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

struct LabelViewModel: PBViewModel {
    let id: String
    let type: ComponentType = .label
    let constraints: [NSLayoutConstraint]
    
    let text: String
    let textColor: UIColor
    let font: UIFont
    let textAlignment: NSTextAlignment
    let numberOfLines: Int
    
    init(
        id: String,
        constraints: [NSLayoutConstraint],
        text: String,
        textColor: UIColor = .black,
        font: UIFont = .systemFont(ofSize: 16),
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1
    ) {
        self.id = id
        self.constraints = constraints
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
