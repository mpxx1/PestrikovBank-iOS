//
//  LayoutConfig.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import UIKit

enum LayoutConfig: Codable {
    case root
    case fillParent(insets: EdgeInsetsConfig, sendToBack: Bool)
    case topAttached(insets: EdgeInsetsConfig)
    case below(component: String, insets: EdgeInsetsConfig)
    case fixedSizeBelow(component: String, size: CGSize, insets: EdgeInsetsConfig)
    case centered(size: CGSize?, insets: EdgeInsetsConfig)
}

enum EdgeInsetsConfig: Codable {
    case zero
    case insets(InsetsConfig)
}

struct InsetsConfig: Codable {
    let top: CGFloat
    let leading: CGFloat
    let trailing: CGFloat
    let bottom: CGFloat
}

extension EdgeInsetsConfig {
    var insets: UIEdgeInsets {
        switch self {
        case .zero:
            return .zero
        case .insets(let config):
            return UIEdgeInsets(top: config.top, left: config.leading, bottom: config.bottom, right: config.trailing)
        }
    }
}
