//
//  LocalBackgroundImageComponent.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

public enum ImageType {
    case local(String)
    case red
    case blue
    case green
    case orange
    case purple
}

public struct ImageComponentConfig {
    let id: String
    let type: ImageType
    let cornerRadius: CGFloat?
    let size: CGSize
}

public class ImageComponent: UIImageView, Component {
    public var id: String
    
    init(config: ImageComponentConfig) {
        id = config.id
        super.init(frame: .zero)
        
        switch config.type {
        case .local(let name):
            image = UIImage(named: name)
        case .red:
            image = createColoredImage(size: config.size, color: .systemRed)
        case .blue:
            image = createColoredImage(size: config.size, color: .systemBlue)
        case .green:
            image = createColoredImage(size: config.size, color: .systemGreen)
        case .orange:
            image = createColoredImage(size: config.size, color: .systemOrange)
        case .purple:
            image = createColoredImage(size: config.size, color: .systemPurple)
        }
        
        if let cornerRadius = config.cornerRadius {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(to viewModel: ViewModelType) {}
    
    public func setupConstraints(in container: UIView, preset: ConstraintPreset) {
        setupConstraintsDefault(self, in: container, preset: preset)
    }
    
    private func createColoredImage(size: CGSize, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
