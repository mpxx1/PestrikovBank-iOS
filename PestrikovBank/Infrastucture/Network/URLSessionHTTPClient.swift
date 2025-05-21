//
//  URLSessionHTTPClient.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Combine
import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func send(_ request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { result -> (Data, HTTPURLResponse) in
                guard let httpRes = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                                
                return (result.data, httpRes)
            }
            .mapError { $0 as! URLError }
            .eraseToAnyPublisher()
    }
}
