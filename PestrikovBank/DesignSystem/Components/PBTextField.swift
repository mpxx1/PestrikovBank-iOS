//
//  PBTextField.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit
import Combine

final class PBTextField: UITextField, PBComponent {
    private var viewModel: TextFieldViewModel?
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
    
    func configure(with viewModel: any PBViewModel) {
        guard viewModel.type == .textField else { return }
        guard let viewModel = viewModel as? TextFieldViewModel else { return }
        
        self.viewModel = viewModel
        
        placeholder = viewModel.placeholder
        text = viewModel.text
        textColor = viewModel.textColor
        font = viewModel.font
        keyboardType = viewModel.keyboardType
        isSecureTextEntry = viewModel.isSecureTextEntry
        autocapitalizationType = viewModel.autocapitalizationType
        
        bindEditingChanged()
    }
    
    private func bindEditingChanged() {        
        self
            .publisher(for: .editingChanged)
            .compactMap { ($0 as! UITextField).text }
            .sink { [weak self] str in
                self?.viewModel?.onEditingChanged?(str)
            }
            .store(in: &cancellables)
    }
}
