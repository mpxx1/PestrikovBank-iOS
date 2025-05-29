//
//  StackViewModelConfig.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import CoreFoundation

struct StackViewModelConfig: Codable {
    let id: String
    let axis: StackAxis
    let alignment: StackAlignment
    let distribution: StackDistribution
    let spacing: CGFloat
    let layout: [LayoutConfig]
    let components: [ComponentConfig]
}

enum StackAxis: String, Codable {
    case vertical
    case horizontal
}

enum StackAlignment: String, Codable {
    case fill
    case center
    case leading
    case trailing
}

enum StackDistribution: String, Codable {
    case fill
    case fillEqually
    case fillProportionally
    case equalSpacing
    case equalCentering
}
