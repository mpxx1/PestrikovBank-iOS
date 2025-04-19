//
//  ProcessTransfer.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

import Combine

public protocol ProcessTransferUseCase {
    func execute(with request: TransferRequest) -> AnyPublisher<Void, Error>
}
