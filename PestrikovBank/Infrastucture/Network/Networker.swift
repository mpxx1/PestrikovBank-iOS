//
//  Networker.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Combine
import Foundation

public protocol Networker {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
    func requestImage(_ endpoint: Endpoint) -> AnyPublisher<Data, Error>
}
