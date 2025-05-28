//
//  PBActivityIndicator.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

final class PBActivityIndicator: UIActivityIndicatorView, PBComponent {
    private var viewModel: ActivityIndicatorViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with viewModel: PBViewModel) {
        guard viewModel.type == .activityIndicator else { return }
        guard let viewModel = viewModel as? ActivityIndicatorViewModel else { return }
        
        self.viewModel = viewModel
        
        hidesWhenStopped = viewModel.hidesWhenStopped
        
        color = viewModel.color
        style = viewModel.style
        viewModel.isActive
            ? startAnimating()
            : stopAnimating()
        
        setupLayout()
    }
    
    private func setupLayout() {
        guard let viewModel = viewModel else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(viewModel.constraints)
    }
}
