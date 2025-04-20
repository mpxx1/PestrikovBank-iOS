//
//  Router.swift
//  PestrikovBank
//
//  Created by m on 19.04.2025.
//

import UIKit

public enum FlowVariant {
    case login
    case main
}

public protocol RouteCoordinator: AnyObject {
    var rootViewController: UIViewController { get }
    func start()
//    func navigate(to route: RouterVariant, animated: Bool)
//    func goBack(animated: Bool)
}
