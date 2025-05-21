//
//  HTTPClient.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Combine
import Foundation

public protocol HTTPClient {
    func send(_ request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
