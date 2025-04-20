//
//  LoginCoordinator.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class LoginCoordinator: RouteCoordinator {

    public var rootViewController: UIViewController
    
    init(
        loginViewController: UIViewController //,
        // signUpViewController: UINavigationController
    ) {
        self.rootViewController = loginViewController
    }
    
    public func start() {
        // todo
    }
}
