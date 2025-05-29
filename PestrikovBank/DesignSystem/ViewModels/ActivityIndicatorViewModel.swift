//
//  ActivityIndicatorViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

struct ActivityIndicatorViewModel: PBViewModel {
    let id: String
    let type: ComponentType = .activityIndicator
    let layout: [LayoutConfig]
    
    let hidesWhenStopped: Bool
    let color: UIColor
    let style: UIActivityIndicatorView.Style
    let isActive: Bool
    
    init(
        id: String,
        hidesWhenStopped: Bool,
        onDarkColor: UIColor,
        onLightColor: UIColor,
        style: UIActivityIndicatorView.Style,
        isActive: Bool,
        layout: [LayoutConfig]
    ) {
        self.id = id
        self.hidesWhenStopped = hidesWhenStopped
        self.color = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return onDarkColor
            } else {
                return onLightColor
            }
        }
        self.style = style
        self.isActive = isActive
        self.layout = layout
    }
}
