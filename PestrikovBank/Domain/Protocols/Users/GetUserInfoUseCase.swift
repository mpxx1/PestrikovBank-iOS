//
//  GetUserInfoUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol GetUserInfoUseCase {
    func execute() -> AnyPublisher<any User, Error>
}
