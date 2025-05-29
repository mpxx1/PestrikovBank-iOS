//
//  StackViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

struct StackViewModel: PBViewModel {
    let id: String
    let type: ComponentType = .stack
    let layout: [LayoutConfig]
    
    let axis: NSLayoutConstraint.Axis
    let alignment: UIStackView.Alignment
    let distribution: UIStackView.Distribution
    let spacing: CGFloat
    
    let components: [PBViewModel]
    
    init(
        id: String,
        layout: [LayoutConfig],
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        components: [PBViewModel]
    ) {
        self.id = id
        self.layout = layout
        self.alignment = alignment
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.components = components
    }
}
