//
//  LoginViewControllerImpl.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import UIKit
import Combine

public final class LoginViewControllerImpl: UIViewController, UITextFieldDelegate {
    
    private var loginForm: LoginFormViewImpl
    private var viewModel: LoginViewModelImpl
    private var cancellables = Set<AnyCancellable>()
    
    private let backgroundImageView: UIImageView = {
        var imageName: String
        let imageView = UIImageView(image: UIImage(named: "LoginLight"))
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
        updateBackgroundImage()
        view.addSubview(loginForm)
        
        loginForm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginForm.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginForm.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loginForm.phoneField.addTarget(self,
            action: #selector(textDidChange(_:)),
            for: .editingChanged)
        
        bindForm()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageView.frame = view.bounds
        loginForm.frame = view.bounds
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
            ? "LoginDark"
            : "LoginLight"
        backgroundImageView.image = UIImage(named: name)
    }
    
    private func bindForm() {
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: loginForm.passwordField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.secret, on: viewModel)
            .store(in: &cancellables)

        viewModel
            .isLoginEnabled
            .assign(to: \.isEnabled, on: loginForm.loginButton)
            .store(in: &cancellables)
        
        viewModel.$state
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
    
    @objc private func textDidChange(_ tf: UITextField) {
        let rawText = tf.text ?? ""

        if tf === loginForm.phoneField {
            let formatted = loginForm.format(
                phoneNumber: rawText,
                shouldRemoveLastDigit: false
            )
            loginForm.phoneField.text = formatted
            viewModel.phoneNumber = formatted
        }

        if tf === loginForm.passwordField {
            viewModel.secret = rawText
        }
    }

}
