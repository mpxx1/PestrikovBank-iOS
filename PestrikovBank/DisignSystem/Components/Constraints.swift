//
//  Constraints.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

public enum ConstraintPreset {
    case fillParent(insets: UIEdgeInsets = .zero, sendToBack: Bool)
    case topAttached(insets: UIEdgeInsets = .zero)
    case below(Component, insets: UIEdgeInsets = .zero)
    case fixedSizeBelow(Component, insets: UIEdgeInsets, size: CGSize)
    case centered(size: CGSize?, insets: UIEdgeInsets = .zero)
}

public func setupConstraintsDefault(
    _ view: Component,
    in container: UIView,
    preset: ConstraintPreset
) {
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
    case .topAttached(let insets):
        constraints = [
            view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
        ]
    case .below(let neighbor, let insets):
        constraints = [
            view.topAnchor.constraint(equalTo: neighbor.bottomAnchor, constant: insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
        ]
    case .fixedSizeBelow(let neighbor, insets: let insets, size: let size):
        constraints = [
            view.topAnchor.constraint(equalTo: neighbor.bottomAnchor, constant: insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            view.widthAnchor.constraint(equalToConstant: size.width),
            view.heightAnchor.constraint(equalToConstant: size.height)
        ]
        
    case .centered(let size, let insets):
        constraints = [
            view.centerXAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerYAnchor)
        ]
        
        if let size = size {
            constraints.append(contentsOf: [
                view.widthAnchor.constraint(equalToConstant: size.width),
                view.heightAnchor.constraint(equalToConstant: size.height)
            ])
        }
        
        if insets != .zero {
            constraints.append(contentsOf: [
                view.leadingAnchor.constraint(greaterThanOrEqualTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
                view.trailingAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
                view.topAnchor.constraint(greaterThanOrEqualTo: container.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                view.bottomAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom)
            ])
        }
    }

    NSLayoutConstraint.activate(constraints)
}
