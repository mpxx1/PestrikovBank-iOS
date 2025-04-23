//
//  AppCoordinator.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit
import Combine

public class AppCoordinator: RouteCoordinator {
    
    public var rootViewController: UIViewController
    var loginCoordinator: RouteCoordinator
    var mainCoordinator: RouteCoordinator
    var window: UIWindow?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        window: UIWindow?,
        loginCoordinator: RouteCoordinator,
        mainCoordinator: RouteCoordinator
    ) {
        self.window = window
        self.loginCoordinator = loginCoordinator
        self.mainCoordinator = mainCoordinator
        
        switch SessionManagerImpl.shared.authState {
        case .loggedOut:
            loginCoordinator.start()
            self.rootViewController = loginCoordinator.rootViewController
            self.window?.rootViewController = self.rootViewController
        case .loggedIn(_):
            mainCoordinator.start()
            self.rootViewController = mainCoordinator.rootViewController
            self.window?.rootViewController = self.rootViewController
        }
        
        bind()
    }
    
    func bind() {
        SessionManagerImpl
            .shared
            .$authState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.start()
            }
            .store(in: &cancellables)
    }

    public func start() {
        switch SessionManagerImpl.shared.authState {
        case .loggedOut:
            loginCoordinator.start()
            self.rootViewController = loginCoordinator.rootViewController
            self.window?.rootViewController = UINavigationController(
                rootViewController: self.rootViewController
            )
        case .loggedIn(_):
            mainCoordinator.start()
            self.rootViewController = mainCoordinator.rootViewController
            self.window?.rootViewController = self.rootViewController
        }
    }
}
