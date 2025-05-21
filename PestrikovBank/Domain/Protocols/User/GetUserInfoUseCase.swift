//
//  GetUserInfoUseCase.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol FetchMeUseCase {
    func execute() -> AnyPublisher<UserImpl, Error>
}
