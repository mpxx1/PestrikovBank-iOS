//
//  PBButton.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit
import Combine

final class PBButton: UIButton, PBComponent {
    private var viewModel: ButtonViewModel?
    private var cancellables = Set<AnyCancellable>()
    private weak var parentComponentDelegate: ParentComponentDelegate?
    
    init(parentComponent: ParentComponentDelegate?) {
        super.init(frame: .zero)
        self.parentComponentDelegate = parentComponent
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configure(with viewModel: PBViewModel) {
        guard viewModel.type == .button else { return }
        guard let viewModel = viewModel as? ButtonViewModel else { return }
        
        self.viewModel = viewModel
        
        setTitle(viewModel.title, for: .normal)
        setTitleColor(viewModel.titleColor, for: .normal)
        titleLabel?.font = viewModel.font
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = viewModel.cornerRadius
        isEnabled = viewModel.isEnabled
        
        bindTapAction()
    }
    
    private func bindTapAction() {
        self
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel?.tapAction?()
            }
            .store(in: &cancellables)
    }
}
