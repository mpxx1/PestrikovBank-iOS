//
//  LoginViewControllerImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import UIKit
import Combine

public final class LoginViewControllerImpl: UIViewController {
    
    private var loginForm: LoginFormViewImpl
    private var viewModel: LoginViewModelImpl
    private var cancellables = Set<AnyCancellable>()
    
    private let backgroundImageView: UIImageView = {
        var imageName: String
        let imageView = UIImageView(image: UIImage(named: "LoginLightBackground"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init(loginForm: LoginFormViewImpl, viewModel: LoginViewModelImpl) {
        self.loginForm = loginForm
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        view.addSubview(loginForm)
        updateBackgroundImage()
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        loginForm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            loginForm.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginForm.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.sendSubviewToBack(backgroundImageView)
        
        loginForm.phoneField.delegate = loginForm
        
        bindForm()
    }
    
    public override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }
        updateBackgroundImage()
    }

    
    private func updateBackgroundImage() {
        let name = traitCollection.userInterfaceStyle == .dark
            ? "LoginDarkBackground"
            : "LoginLightBackground"
        backgroundImageView.image = UIImage(named: name)
    }
    
    private func bindForm() {
        loginForm
            .phoneField
            .publisher(for: .editingChanged)
            .compactMap { ($0 as! UITextField).text }
            .assign(to: \.phoneNumber, on: viewModel)
            .store(in: &cancellables)
        
        loginForm
            .passwordField
            .publisher(for: .editingChanged)
            .compactMap { ($0 as! UITextField).text ?? "" }
            .assign(to: \.secret, on: viewModel)
            .store(in: &cancellables)
        
        loginForm
            .loginButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.submitLogin()
            }
            .store(in: &cancellables)

        viewModel
            .isLoginEnabled
            .assign(to: \.isEnabled, on: loginForm.loginButton)
            .store(in: &cancellables)
        
        viewModel
            .$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                                
                switch state {
                case .loading:
                    self?.loginForm.loginButton.isEnabled = false
                    self?.loginForm.loginButton.titleLabel?.text = "Loading..."
                case .failed(let error):
                    self?.showErrorAlert(message: error.localizedDescription)
                case .succeeded: break
                    // todo routing
                case .none:
                    break
                }
            }
            .store(in: &cancellables)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}
