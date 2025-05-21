//
//  ViewDIContainer.swift
//  PestrikovBank
//
//  Created by m on 20.04.2025.
//

import UIKit

public class ViewDIContainer {
    struct Dependencies {
        let modelDIContainer: ViewModelDIContainer
    }
    
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var loginForm: LoginFormView = {
        return LoginFormView(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies
                .modelDIContainer
                .loginViewModel
                .phoneFormat()
        )
    }()
    
    lazy var signUpForm: SignUpFormView = {
        return SignUpFormView(
            frame: UIScreen.main.bounds,
            phoneNumberFormatting: dependencies
                .modelDIContainer
                .signUpViewModel
                .phoneFormat()
        )
    }()
    
    lazy var dsAccountDetailsFormView: DSAccountDetailsFormView = {
        return DSAccountDetailsFormView(
            frame: UIScreen.main.bounds,
            viewModel: dependencies.modelDIContainer.accountsViewModel,
            screenTitleComponintConfig: LabelComponentConfig(
                id: "title", text: "Details", fontSize: 32, fontWeight: .bold, color: .system
            ),
            cardImageConfig: ImageComponentConfig(id: "account_card-image", type: .red, cornerRadius: 8, size: CGSize(width: 300, height: 180)),
            accountIdLabelConfig: LabelComponentConfig(
                id: "account_id_label", text: "Account ID", fontSize: 12, fontWeight: .medium, color: .system
            ),
            accountIdConfig: LabelComponentConfig(id: "account_id", text: "", fontSize: 20, fontWeight: .bold, color: .system),
            amountLabelConfig: LabelComponentConfig(id: "amount_label", text: "Amount", fontSize: 12, fontWeight: .medium, color: .system),
            amountConfig: LabelComponentConfig(id: "amount", text: "", fontSize: 20, fontWeight: .bold, color: .system),
            accountTypeLabelConfig: LabelComponentConfig(id: "account_type_label", text: "Type", fontSize: 12, fontWeight: .medium, color: .system),
            accountTypeConfig: LabelComponentConfig(id: "account_type", text: "", fontSize: 20, fontWeight: .bold, color: .system),
            createdAtLabelConfig: LabelComponentConfig(id: "created_at_label", text: "Created at", fontSize: 12, fontWeight: .medium, color: .system),
            createdAtConfig: LabelComponentConfig(id: "created_at", text: "", fontSize: 20, fontWeight: .bold, color: .system)
        )
    }()
}
