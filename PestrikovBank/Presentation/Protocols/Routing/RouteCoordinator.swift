//
//  Router.swift
//  PestrikovBank
//
//  Created by m on 19.04.2025.
//

import UIKit

public protocol RouteCoordinator: AnyObject {
    var rootViewController: UIViewController { get }
    func start()
}
