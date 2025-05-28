//
//  PBStack.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

final class PBStack: UIStackView, PBComponent {
    private var viewModel: StackViewModel?
    private var components: [PBComponent] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with viewModel: PBViewModel) {
        guard viewModel.type == .stack else { return }
        guard let viewModel = viewModel as? StackViewModel else { return }
        
        self.viewModel = viewModel
        
        axis = viewModel.axis
        alignment = viewModel.alignment
        distribution = viewModel.distribution
        spacing = viewModel.spacing
        
        components.removeAll()
        subviews.forEach {  $0.removeFromSuperview() }
        
        viewModel
            .components
            .forEach { item in
                components.append(item)
                addArrangedSubview(item)
            }
        
        setupLayout()
    }
    
    private func setupLayout() {
        guard let viewModel = viewModel else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(viewModel.constraints)
    }
}
