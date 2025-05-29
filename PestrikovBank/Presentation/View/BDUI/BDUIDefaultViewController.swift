//
//  DefaultBDUIViewController.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import UIKit
import Combine

final class BDUIDefaultViewController: UIViewController {
    private let viewModel: BDUIDefaultViewModel
    private let mapper: PBMapper
    private let endpoint: String
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var cancellables = Set<AnyCancellable>()
    

    init(viewModel: BDUIDefaultViewModel, mapper: PBMapper, endpoint: String) {
        self.viewModel = viewModel
        self.mapper = mapper
        self.endpoint = endpoint
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapReloadScreen(_:)),
            name: .didTapReloadScreen,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapLogout),
            name: .didTapLogout,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        observeSession()
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func observeSession() {
        SessionManagerImpl
            .shared
            .currentUserPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] authState in
                switch authState {
                case .loggedIn(let user):
                    self?.loadData(for: UserIdImpl(id: user.id))
                case .loggedOut:
                    self?.presentErrorAlert(error: "Unauthorized" as! Error)
                case .loading:
                    break
                }
            }
            .store(in: &cancellables)
    }

    private func loadData(for user: UserId) {
        activityIndicator.startAnimating()

        Task {
            do {
                let config = try await viewModel.loadScreen(for: user, path: endpoint)
                let componentView = mapper.mapConfig(config.view)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.view.addSubview(componentView)
                    self.setupConstraints(for: componentView)
                }
            } catch {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.presentErrorAlert(error: error)
                }
            }
        }
    }

    private func setupConstraints(for componentView: UIView) {
        componentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            componentView.topAnchor.constraint(equalTo: view.topAnchor),
            componentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            componentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            componentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func presentErrorAlert(error: Error) {
        let message: String
        if let localizedError = error as? LocalizedError, let errorDescription = localizedError.errorDescription {
            message = errorDescription
        } else {
            message = error.localizedDescription
        }

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BDUIDefaultViewController {
    @objc private func didTapLogout() {
        viewModel.logout()
    }

    @objc private func didTapReloadScreen(_ notification: Notification) {
        if case .loggedIn(let user) = SessionManagerImpl.shared.currentUserPublisher.value {
            loadData(for: UserIdImpl(id: user.id))
        }
    }
}

extension Notification.Name {
    static let didTapReloadScreen = Notification.Name("didTapReloadScreen")
    static let didTapLogout = Notification.Name("didTapLogout")
}
