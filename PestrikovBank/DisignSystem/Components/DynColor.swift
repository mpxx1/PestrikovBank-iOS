//
//  DynColor.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

public enum ColorVariant {
    case system
    case systemRed
    case systemBlue
    case systemGreen
    case systemOrange
    case systemPurple
    case single(UIColor)
    case dynamic(onLight: UIColor, onDark: UIColor)
}

public func dynColor(onLight: UIColor, onDark: UIColor) -> UIColor {
    UIColor { trait in
        switch trait.userInterfaceStyle {
        case .dark:
            return onDark
        default:
            return onLight
        }
    }
}
