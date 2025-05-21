//
//  Component.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit

public protocol Component: UIView {
    var id: String { get }
    
    func bind(to viewModel: ViewModelType)
    func setupConstraints(in container: UIView, preset: ConstraintPreset)
}
