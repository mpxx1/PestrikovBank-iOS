//
//  MainCoordinator.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class MainCoordinator: RouteCoordinator {

    public var rootViewController: UIViewController
    var childCoordinators = [RouteCoordinator]()
    
    init(
        accountsTabCoordinator: RouteCoordinator,
        paymentsTabCoordinator: RouteCoordinator,
        transactionsTabCoordinator: RouteCoordinator
    ) {
        let tabBarController = UITabBarController()
        
        let tabBar = tabBarController.tabBar
        tabBar.isTranslucent = false
        
        let dynamicTint = UIColor { trait in
            switch trait.userInterfaceStyle {
            case .dark:
                return #colorLiteral(red: 0.6782359481, green: 0, blue: 0, alpha: 1)
            default:
                return .systemRed
            }
        }
        tabBarController.tabBar.tintColor = dynamicTint
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tabBar.insertSubview(blurView, at: 0)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        self.rootViewController = tabBarController
        childCoordinators = [
            accountsTabCoordinator,
            paymentsTabCoordinator,
            transactionsTabCoordinator
        ]
    }
    
    public func start() {
        guard let tabBarController = rootViewController as? UITabBarController else {
            return
        }
        
        let vcs = childCoordinators
            .enumerated()
            .map { index, coordinator -> UIViewController in
                
            coordinator.start()
            
            let vc = coordinator.rootViewController
            
            switch index {
            case 0:
                setupChildController(
                    vc: vc,
                    title: "Home",
                    imageName: "house",
                    selectedImageName: "house.fill"
                )
            case 1:
                setupChildController(
                    vc: vc,
                    title: "Payments",
                    imageName: "sterlingsign.square",
                    selectedImageName: "sterlingsign.square.fill"
                )
            case 2:
                setupChildController(
                    vc: vc,
                    title: "Transactions",
                    imageName: "clock",
                    selectedImageName: "clock.fill"
                )
            default:
                break
            }
            
            return vc
        }
        
        tabBarController.viewControllers = vcs
    }
    
    private func setupChildController(
        vc: UIViewController,
        title: String,
        imageName: String,
        selectedImageName: String
    ) {
        vc.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: imageName),
            selectedImage: UIImage(systemName: selectedImageName)
        )
    }
}
