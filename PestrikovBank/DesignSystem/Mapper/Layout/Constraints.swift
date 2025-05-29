//
//  Constraints.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import UIKit

func makeConstraints(
    _ view: PBComponent,
    parent: ParentComponentDelegate?,
    preset: LayoutConfig
) -> [NSLayoutConstraint] {
    var constraints: [NSLayoutConstraint] = []
    guard let container = parent?.delegate?.childComponents()["parent"] else { return [] }

    switch preset {
    case .fillParent(let insets, let sendToBack):
        constraints = [
            view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: insets.insets.top),
            view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -insets.insets.bottom),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.insets.right)
        ]

        if sendToBack {
            container.sendSubviewToBack(view)
        }
    case .topAttached(let insets):
        constraints = [
            view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: insets.insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.insets.right)
        ]
    case .below(let neighbor, let insets):
        guard let neighbor = parent?.delegate?.childComponents()[neighbor] else { break }
        
        constraints = [
            view.topAnchor.constraint(equalTo: neighbor.bottomAnchor, constant: insets.insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.insets.left),
            view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.insets.right)
        ]
    case .fixedSizeBelow(let neighbor, size: let size, insets: let insets):
        guard let neighbor = parent?.delegate?.childComponents()[neighbor] else { break }
        
        constraints = [
            view.topAnchor.constraint(equalTo: neighbor.bottomAnchor, constant: insets.insets.top),
            view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.insets.left),
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

        if insets.insets != .zero {
            constraints.append(contentsOf: [
                view.leadingAnchor.constraint(greaterThanOrEqualTo: container.safeAreaLayoutGuide.leadingAnchor, constant: insets.insets.left),
                view.trailingAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -insets.insets.right),
                view.topAnchor.constraint(greaterThanOrEqualTo: container.safeAreaLayoutGuide.topAnchor, constant: insets.insets.top),
                view.bottomAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -insets.insets.bottom)
            ])
        }
    case .root:
        break
    }
    
    return constraints
}
