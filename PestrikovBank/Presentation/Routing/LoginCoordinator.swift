//
//  LoginCoordinator.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class LoginCoordinator: RouteCoordinator {
    
    public var rootViewController: UIViewController
    public var childCoordinators = [UIViewController]()
    
    init(
        loginViewController: UIViewController,
        signUpViewController: UIViewController
    ) {
        self.rootViewController = loginViewController
        self.childCoordinators.append(signUpViewController)
    }
    
    public func start() {
        guard let loginViewController = rootViewController as? LoginViewController else {
            return
        }
        
        loginViewController.onSignUpTapped = { [weak self] in
            self?.navigateToSignUp()
        }
    }
    
    private func navigateToSignUp() {
        let navigation = UINavigationController(rootViewController: childCoordinators[0])
        navigation.modalPresentationStyle = .pageSheet
        navigation.modalTransitionStyle = .coverVertical
        rootViewController.present(navigation, animated: true)
    }
}
