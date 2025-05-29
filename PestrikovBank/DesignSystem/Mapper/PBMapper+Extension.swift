//
//  PBMapper.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import UIKit
import Combine

struct PBMapper {
    private let viewModelDIContainer: ViewModelDIContainer
    
    init(ViewModelDIContainer: ViewModelDIContainer) {
        self.viewModelDIContainer = ViewModelDIContainer
    }
    
    func mapConfig(_ config: ComponentConfig) -> PBViewModel {
        switch config {
        case .stack(let stackConfig):
            return mapStackConfig(stackConfig)
        case .label(let labelConfig):
            return mapLabelConfig(labelConfig)
        case .image(let imageConfig):
            return mapImageConfig(imageConfig)
        case .button(let buttonConfig):
            return mapButtonConfig(buttonConfig)
        case .textField(let textFieldConfig):
            return mapTextFieldConfig(textFieldConfig)
        }
    }

    private func mapStackConfig(_ config: StackViewModelConfig) -> StackViewModel {
        let components = config.components.map { mapConfig($0) }
        
        return StackViewModel(
            id: config.id,
            layout: config.layout,
            axis: mapStackAxis(config.axis),
            alignment: mapStackAlignment(config.alignment),
            distribution: mapStackDistribution(config.distribution),
            spacing: config.spacing,
            components: components
        )
    }

    private func mapLabelConfig(_ config: LabelViewModelConfig) -> LabelViewModel {
        return LabelViewModel(
            id: config.id,
            layout: config.layout,
            text: config.text,
            textColor: UIColor(hex: config.textColor) ?? .black,
            font: mapFontConfig(config.font),
            textAlignment: mapTextAlignment(config.textAlignment),
            numberOfLines: config.numberOfLines
        )
    }

    private func mapImageConfig(_ config: ImageViewModelConfig) -> ImageViewModel {
        return ImageViewModel(
            id: config.id,
            layout: config.layout,
            imageType: config.imageType,
            size: config.size,
            contentMode: mapContentMode(config.contentMode),
            cornerRadius: config.cornerRadius,
        )
    }

    private func mapButtonConfig(_ config: ButtonViewModelConfig) -> ButtonViewModel {
        return ButtonViewModel(
            id: config.id,
            layout: config.layout,
            title: config.title,
            titleColor: UIColor(hex: config.titleColor) ?? .white,
            backgroundColor: UIColor(hex: config.backgroundColor) ?? .systemRed,
            cornerRadius: config.cornerRadius,
            font: mapFontConfig(config.font),
            isEnabled: config.isEnabled,
            tapAction: extractClosure(with: config.closureKey) as? () -> Void
        )
    }

    private func mapTextFieldConfig(_ config: TextFieldViewModelConfig) -> TextFieldViewModel {
        return TextFieldViewModel(
            id: config.id,
            layout: config.layout,
            placeholder: config.placeholder,
            textColor: UIColor(hex: config.textColor) ?? .black,
            font: mapFontConfig(config.font),
            keyboardType: mapKeyboardType(config.keyboardType),
            isSecureTextEntry: config.isSecureTextEntry,
            autocapitalizationType: mapAutocapitalizationType(config.autocapitalizationType),
            onEditChanged: extractClosure(with: config.closureKey) as? (String) -> Void
        )
    }
    
    private func extractClosure(with config: ClosureKey) -> Any? {
        return viewModelDIContainer.models[config.viewModel]?.cancellables[config.closure]
    }

    private func mapStackAxis(_ axis: StackAxis) -> NSLayoutConstraint.Axis {
        switch axis {
        case .vertical: return .vertical
        case .horizontal: return .horizontal
        }
    }

    private func mapStackAlignment(_ alignment: StackAlignment) -> UIStackView.Alignment {
        switch alignment {
        case .fill: return .fill
        case .center: return .center
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }

    private func mapStackDistribution(_ distribution: StackDistribution) -> UIStackView.Distribution {
        switch distribution {
        case .fill: return .fill
        case .fillEqually: return .fillEqually
        case .fillProportionally: return .fillProportionally
        case .equalSpacing: return .equalSpacing
        case .equalCentering: return .equalCentering
        }
    }

    private func mapTextAlignment(_ alignment: TextAlignment) -> NSTextAlignment {
        switch alignment {
        case .left: return .left
        case .center: return .center
        case .right: return .right
        case .justified: return .justified
        case .natural: return .natural
        }
    }

    private func mapFontConfig(_ config: SystemFontConfig) -> UIFont {
        let weight: UIFont.Weight
        switch config.weight {
        case .regular: weight = .regular
        case .medium: weight = .medium
        case .bold: weight = .bold
        }
        return UIFont.systemFont(ofSize: config.size, weight: weight)
    }

    private func mapContentMode(_ contentMode: ContentMode) -> UIView.ContentMode {
        switch contentMode {
        case .scaleToFill: return .scaleToFill
        case .scaleAspectFit: return .scaleAspectFit
        case .scaleAspectFill: return .scaleAspectFill
        case .redraw: return .redraw
        case .center: return .center
        case .top: return .top
        case .bottom: return .bottom
        case .left: return .left
        case .right: return .right
        case .topLeft: return .topLeft
        case .topRight: return .topRight
        case .bottomLeft: return .bottomLeft
        case .bottomRight: return .bottomRight
        }
    }

    private func mapKeyboardType(_ type: KeyboardType) -> UIKeyboardType {
        switch type {
        case .base: return .default
        case .numberPad: return .numberPad
        }
    }

    private func mapAutocapitalizationType(_ type: TextAutocapitalizationType) -> UITextAutocapitalizationType {
        switch type {
        case .none: return .none
        case .words: return .words
        case .sentences: return .sentences
        case .allCharacters: return .allCharacters
        }
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
