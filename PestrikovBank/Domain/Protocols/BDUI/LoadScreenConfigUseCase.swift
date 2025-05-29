//
//  LoadScreenConfigUseCase.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

import Combine

protocol LoadScreenConfigUseCase {
    func execute(user: UserId, path: String) async throws -> ScreenConfig
}
