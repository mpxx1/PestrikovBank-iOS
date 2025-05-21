//
//  SceenDelegate.swift
//  PestrikovBank
//
//  Created by m on 17.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: RouteCoordinator?
    var appDIContainer: AppDIContainer = AppDIContainer()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let appCoordinator = AppCoordinator(
            window: self.window,
            loginCoordinator: appDIContainer.routeCoordinatorDIContainer.loginCooridnator,
            mainCoordinator: appDIContainer.routeCoordinatorDIContainer.mainCoordinator
        )
        appCoordinator.start()
        
        self.appCoordinator = appCoordinator
        window?.makeKeyAndVisible()
    }
}

