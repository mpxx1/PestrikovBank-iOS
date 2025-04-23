//
//  SignUpViewControllerImpl+Extension.swift
//  PestrikovBank
//
//  Created by m on 21.04.2025.
//

import UIKit
import Combine

public final class SignUpViewController: UIViewController {
    
    private var signUpForm: SignUpFormView
    private var viewModel: SignUpViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let backgroundImageView: UIImageView = {
        var imageName: String
        let imageView = UIImageView(image: UIImage(named: "LoginLightBackground"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init(
        signUpForm: SignUpFormView,
        signUpViewModel: SignUpViewModel
    ) {
        self.signUpForm = signUpForm
        self.viewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        view.addSubview(signUpForm)
        updateBackgroundImage()
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        signUpForm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            signUpForm.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signUpForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpForm.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.sendSubviewToBack(backgroundImageView)
        
        signUpForm.phoneField.delegate = signUpForm
        
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
        signUpForm
            .phoneField
            .publisher(for: .editingChanged)
            .compactMap { ($0 as! UITextField).text }
            .assign(to: \.phoneNumber, on: viewModel)
            .store(in: &cancellables)
        
        signUpForm
            .passwordField
            .publisher(for: .editingChanged)
            .compactMap { ($0 as! UITextField).text ?? "" }
            .assign(to: \.secret, on: viewModel)
            .store(in: &cancellables)
        
        signUpForm
            .confirmPasswordField
            .publisher(for: .editingChanged)
            .compactMap { ($0 as! UITextField).text ?? "" }
            .assign(to: \.confirmSecret, on: viewModel)
            .store(in: &cancellables)
        
        signUpForm
            .signUpButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.submitSignUp()
            }
            .store(in: &cancellables)
        
        viewModel
            .isSignUpEnabled
            .assign(to: \.isEnabled, on: signUpForm.signUpButton)
            .store(in: &cancellables)
        
        viewModel
            .$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                                
                switch state {
                case .loading:
                    self?.signUpForm.signUpButton.isEnabled = false
                    self?.signUpForm.signUpButton.titleLabel?.text = "Loading..."
                case .failed(let error):
                    self?.showErrorAlert(message: error.localizedDescription)
                case .succeeded:
                    break
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
