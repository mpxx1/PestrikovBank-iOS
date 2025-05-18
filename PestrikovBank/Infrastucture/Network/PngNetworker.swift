//
//  PngNetworker.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Combine
import Foundation

public class PngNetworker: Networker {
    
    init(client: HTTPClient) {
        
    }
    public func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, any Error> {
        fatalError("PngNetworker does not support json loading")
    }
    
    public func requestImage(_ endpoint: Endpoint) -> AnyPublisher<Data, any Error> {
        fatalError("not implemented")
    }
}
