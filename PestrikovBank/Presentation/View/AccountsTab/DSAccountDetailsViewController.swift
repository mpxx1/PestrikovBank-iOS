//
//  DSAccountDetailsViewController.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

public class DSAccountDetailsViewController: UIViewController {
    private let viewModel: AccountsViewModel
    private var form: DSAccountDetailsFormView!
    private var viewDIContainer: ViewDIContainer

    init(viewModel: AccountsViewModel, viewDIContainer: ViewDIContainer) {
        self.viewModel = viewModel
        self.viewDIContainer = viewDIContainer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        form = viewDIContainer.dsAccountDetailsFormView
        view.addSubview(form)
        form.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: view.topAnchor),
            form.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            form.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            form.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
