//
//  ImageViewModelConfig.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import UIKit

struct ImageViewModelConfig: Codable {
    let id: String
    let imageType: ImageType
    let size: CGSize
    let contentMode: ContentMode
    let cornerRadius: CGFloat
    let layout: [LayoutConfig]
}

enum ContentMode: String, Codable {
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case redraw
    case center
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}
