//
//  BDUIDefaultViewModel.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import Combine

class BDUIDefaultViewModel {
    private let loadScreenConfigUseCase: LoadScreenConfigUseCase
    private var cancellables: Set<AnyCancellable> = []

    init(loadScreenConfigUseCase: LoadScreenConfigUseCase) {
        self.loadScreenConfigUseCase = loadScreenConfigUseCase
    }

    func loadScreen(for user: UserId, path: String) async throws -> ScreenConfig {
        return try await loadScreenConfigUseCase.execute(user: user, path: path)
    }
    
    func logout() {
        _ = SessionManagerImpl.shared.logout()
    }
}
