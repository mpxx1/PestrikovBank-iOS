//
//  PBComponent.swift
//  PestrikovBank
//
//  Created by m on 28.05.2025.
//

import UIKit

protocol PBComponent: UIView {
    func configure(with viewModel: PBViewModel)
}
