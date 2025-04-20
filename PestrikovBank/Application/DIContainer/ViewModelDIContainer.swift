//
//  ViewModelDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewModelDIContainer {
    struct Dependencies {}
    
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginViewModel: LoginViewModelImpl = {
        return LoginViewModelImpl()
    }()
}
