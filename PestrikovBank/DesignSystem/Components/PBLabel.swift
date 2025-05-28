//
//  PBLabel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

final class PBLabel: UILabel, PBComponent {
    private var viewModel: LabelViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with viewModel: PBViewModel) {
        guard viewModel.type == .label else { return }
        guard let viewModel = viewModel as? LabelViewModel else { return }
        
        self.viewModel = viewModel
        
        text = viewModel.text
        textColor = viewModel.textColor
        font = viewModel.font
        textAlignment = viewModel.textAlignment
        numberOfLines = viewModel.numberOfLines
        
        setupLayout()
    }
    
    private func setupLayout() {
        guard let viewModel = viewModel else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(viewModel.constraints)
    }
}
