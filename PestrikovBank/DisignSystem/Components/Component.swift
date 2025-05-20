//
//  Component.swift
//  PestrikovBank
//
//  Created by m on 18.05.2025.
//

import UIKit

public protocol Component {
    var identifier: String { get }
    var view: UIView { get }
    
    mutating func bind(to viewModel: AnyObject, of type: ViewModelType)
    func switchTheme()
}
