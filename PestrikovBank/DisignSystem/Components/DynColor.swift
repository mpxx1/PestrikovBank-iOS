//
//  DynColor.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

func dynColor(onLight: UIColor, onDark: UIColor) -> UIColor {
    UIColor { trait in
        switch trait.userInterfaceStyle {
        case .dark:
            return onDark
        default:
            return onLight
        }
    }
}
