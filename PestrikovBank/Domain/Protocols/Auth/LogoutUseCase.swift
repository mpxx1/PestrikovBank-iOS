//
//  LogoutUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol LogoutUseCase {
    func execute() -> AnyPublisher<Void, Error>
}
