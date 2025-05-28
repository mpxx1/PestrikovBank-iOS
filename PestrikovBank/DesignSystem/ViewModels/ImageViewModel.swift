//
//  ImageViewModel.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

struct ImageViewModel: PBViewModel {
    let id: String
    let type: ComponentType = .image
    let constraints: [NSLayoutConstraint]
    
    let imageType: ImageType
    let size: CGSize
    let contentMode: UIView.ContentMode
    let cornerRadius: CGFloat
    
    init(
        id: String,
        constraints: [NSLayoutConstraint],
        imageType: ImageType,
        size: CGSize,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        tintColor: UIColor? = nil,
        cornerRadius: CGFloat = 0,
    ) {
        self.id = id
        self.constraints = constraints
        self.imageType = imageType
        self.size = size
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
    }
}

public enum ImageType {
    case local(String)
    case red
    case blue
    case green
    case orange
    case purple
}
