//
//  ComponentConfig.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

enum ComponentConfig: Codable {
    case stack(StackViewModelConfig)
    case label(LabelViewModelConfig)
    case image(ImageViewModelConfig)
    case button(ButtonViewModelConfig)
    case textField(TextFieldViewModelConfig)
}

struct ScreenConfig: Codable {
    let view: ComponentConfig
}
