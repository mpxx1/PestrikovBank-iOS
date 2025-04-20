//
//  AppCoordinator.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class AppCoordinator: RouteCoordinator {
    
    public var rootViewController: UIViewController
    var loginCoordinator: RouteCoordinator
    var mainCoordinator: RouteCoordinator
    
    init(
        loginCoordinator: RouteCoordinator,
        mainCoordinator: RouteCoordinator
    ) {
        self.loginCoordinator = loginCoordinator
        self.mainCoordinator = mainCoordinator
        
        switch SessionManagerImpl.shared.authState {
        case .loggedOut:
            rootViewController = loginCoordinator.rootViewController
        case .loggedIn(let tokens):
            // todo to mainCoordinator
            rootViewController = loginCoordinator.rootViewController
        }
    }

    public func start() {
        switch SessionManagerImpl.shared.authState {
        case .loggedOut:
            rootViewController = loginCoordinator.rootViewController
        case .loggedIn(let tokens):
            // todo change rootViewController
            break
        }
    }
}
