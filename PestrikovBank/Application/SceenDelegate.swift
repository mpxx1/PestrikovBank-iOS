//
//  SceenDelegate.swift
//  PestrikovBank
//
//  Created by m on 17.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let model = LoginViewModelImpl()
        window?.rootViewController = LoginViewControllerImpl(
            loginForm: LoginFormViewImpl(
                frame: window?.bounds ?? UIScreen.main.bounds,
                phoneNumberFormatting: model.phoneFormat()
            ),
            viewModel: model
        )
        window?.makeKeyAndVisible()
    }
}

