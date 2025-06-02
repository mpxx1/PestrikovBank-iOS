//
//  ButtonViewModelConfig.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import UIKit

struct ButtonViewModelConfig: Codable {
    let id: String
    let title: String
    let titleColor: String
    let backgroundColor: String
    let cornerRadius: CGFloat
    let font: SystemFontConfig
    let isEnabled: Bool
    let closureKey: String?
    let layout: [LayoutConfig]
}
