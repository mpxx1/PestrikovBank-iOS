//
//  PBViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

protocol PBViewModel {
    var id: String { get }
    var type: ComponentType { get }
    var constraints: [NSLayoutConstraint] { get }
}

enum ComponentType: String {
    case label
    case textField
    case button
    case image
    case activityIndicator
    case stack
}
