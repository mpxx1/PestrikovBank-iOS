//
//  PBImage.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

final class PBImage: UIImageView, PBComponent {
    private var viewModel: ImageViewModel?
    private weak var parentComponentDelegate: ParentComponentDelegate?
    
    init(parentComponent: ParentComponentDelegate?) {
        super.init(frame: .zero)
        self.parentComponentDelegate = parentComponent
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with viewModel: PBViewModel) {
        guard viewModel.type == .image else { return }
        guard let viewModel = viewModel as? ImageViewModel else { return }
        
        contentMode = viewModel.contentMode
        layer.cornerRadius = viewModel.cornerRadius
        
        switch viewModel.imageType {
        case .local(let name):
            image = UIImage(named: name)
        case .data(let data):
            image = UIImage(data: data)
        case .red:
            image = createColoredImage(size: viewModel.size, color: .systemRed)
        case .blue:
            image = createColoredImage(size: viewModel.size, color: .systemBlue)
        case .green:
            image = createColoredImage(size: viewModel.size, color: .systemGreen)
        case .orange:
            image = createColoredImage(size: viewModel.size, color: .systemOrange)
        case .purple:
            image = createColoredImage(size: viewModel.size, color: .systemPurple)
        }
    }
    
    private func createColoredImage(size: CGSize, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
