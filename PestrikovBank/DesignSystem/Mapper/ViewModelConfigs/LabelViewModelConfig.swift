//
//  LabelViewModelConfig.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import Foundation

struct LabelViewModelConfig: Codable {
    let id: String
    let layout: [LayoutConfig]
    let text: String
    let font: SystemFontConfig
    let textAlignment: TextAlignment
    let numberOfLines: Int
    let textColor: String
}

struct SystemFontConfig: Codable {
    let size: CGFloat
    let weight: TextWeight
}

enum TextWeight: String, Codable {
    case regular
    case medium
    case bold
}

enum TextAlignment: String, Codable {
    case left
    case center
    case right
    case justified
    case natural
}
