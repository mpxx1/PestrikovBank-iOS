//
//  PBStack.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

final class PBStack: UIStackView, PBComponent {
    private var viewModel: StackViewModel?
    private var components: [String:PBComponent] = [:]    
    private weak var parentComponentDelegate: ParentComponentDelegate?
    
    init(parentComponent: ParentComponentDelegate?) {
        super.init(frame: .zero)
        self.parentComponentDelegate = parentComponent
    }
    
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
        
        components[viewModel.id] = self
        components["parent"] = self
        setupLayout()
        
        viewModel
            .components
            .forEach { componentViewModel in
                let component = mapViewModelToComponent(componentViewModel)
                components[componentViewModel.id] = component
                addArrangedSubview(component)
                
                component.translatesAutoresizingMaskIntoConstraints = false
                
                var constraints = [NSLayoutConstraint]()
                componentViewModel
                    .layout
                    .forEach { layout in
                        let con = makeConstraints(component, parent: parentComp(), preset: layout)
                        con.forEach { constraints.append($0) }
                    }
                NSLayoutConstraint.activate(constraints)
            }
    }
    
    private func setupLayout() {
        guard let viewModel = viewModel else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        for layout in viewModel.layout {
            let con = makeConstraints(self, parent: parentComponentDelegate, preset: layout)
            con.forEach { constraints.append($0) }
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    private func mapViewModelToComponent(_ viewModel: PBViewModel) -> PBComponent {
        switch viewModel.type {
        case .label:
            let label = PBLabel(parentComponent: parentComp())
            label.configure(with: viewModel)
            return label
        case .textField:
            let textField = PBTextField(parentComponent: parentComp())
            textField.configure(with: viewModel)
            return textField
        case .button:
            let button = PBButton(parentComponent: parentComp())
            button.configure(with: viewModel)
            return button
        case .image:
            let imageView = PBImage(parentComponent: parentComp())
            imageView.configure(with: viewModel)
            return imageView
        case .activityIndicator:
            let activityIndicator = PBActivityIndicator(parentComponent: parentComp())
            activityIndicator.configure(with: viewModel)
            return activityIndicator
        case .stack:
            let stack = PBStack(parentComponent: parentComp())
            stack.configure(with: viewModel)
            return stack
        }
    }
    
    private func parentComp() -> ParentComponentDelegate {
        return ParentComponentDelegate(parentComponent: self)
    }
}

extension PBStack: ParentComponent {
    func childComponents() -> [String : PBComponent] {
        return components
    }
}
