//
//  AppDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class AppDIContainer {
    
    lazy var appConfiguration = AppConfig()
    lazy var jsonEncoder = JSONEncoder()
    
    lazy var networkerFactory: NetworkerDIContainer = {
        return NetworkerDIContainer()
    }()
    
    lazy var stringFormatDIContainer: StringFormatDIContainer = {
        return StringFormatDIContainer()
    }()
    
    lazy var useCasesDIContainer: UseCasesDIContainer = {
        return UseCasesDIContainer(
            dependencies: UseCasesDIContainer.Dependencies(
                networkerDI: NetworkerDIContainer(),
                jsonEncoder: jsonEncoder
            )
        )
    }()
    
    lazy var viewModelDIContainer: ViewModelDIContainer = {
        return ViewModelDIContainer(dependencies: ViewModelDIContainer.Dependencies(
            phoneFormatter: stringFormatDIContainer.phoneNumberFormatter,
            signUpUseCase: useCasesDIContainer.signUpUseCase
        ))
    }()

    lazy var viewDIContainer: ViewDIContainer = {
        return ViewDIContainer(dependencies: ViewDIContainer.Dependencies(
            modelDIContainer: viewModelDIContainer
        ))
    }()
    
    lazy var viewControllerDIContainer: ViewControllerDIContainer = {
        return ViewControllerDIContainer(
            dependencies: ViewControllerDIContainer.Dependencies(
                viewDIContainer: viewDIContainer,
                modelDIContainer: viewModelDIContainer
            )
        )
    }()

    lazy var routeCoordinatorDIContainer: RouteCoordinatorDIContainer = {
        return RouteCoordinatorDIContainer(
            dependencies: RouteCoordinatorDIContainer.Dependencies(
                controllerDIContainer: viewControllerDIContainer
            )
        )
    }()
}
