//
//  Constraints.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

public enum ConstraintPreset {
    case fillParent(insets: UIEdgeInsets = .zero, sendToBack: Bool)
    case below(Component, insets: UIEdgeInsets = .zero)
    case custom((UIView) -> [NSLayoutConstraint])
}

public func setupConstraintsDefault(
    _ component: Component,
    in container: UIView,
    preset: ConstraintPreset
) {
    let view = component.view
    view.translatesAutoresizingMaskIntoConstraints = false
    var constraints: [NSLayoutConstraint] = []

    switch preset {
    case .fillParent(let insets, let sendToBack):
        constraints = [
            view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
        ]
        
        if sendToBack {
            container.sendSubviewToBack(view)
        }
    case .below(let neighbor, let insets):
        constraints = [
            view.topAnchor.constraint(equalTo: neighbor.view.bottomAnchor, constant: insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
        ]
    case .custom(let builder):
        constraints = builder(view)
    }

    NSLayoutConstraint.activate(constraints)
}
