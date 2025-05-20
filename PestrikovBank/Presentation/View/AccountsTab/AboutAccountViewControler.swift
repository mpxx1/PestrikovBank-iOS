//
//  AccountAboutViewControler.swift
//  PestrikovBank
//
//  Created by m on 20.05.2025.
//

import UIKit

public class AboutAccountViewControler: UIViewController {
    private let viewModel: AccountsViewModel
    private var form: AboutAccountFormView!

    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel
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
        form = AboutAccountFormView(frame: .zero, viewModel: viewModel)
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
