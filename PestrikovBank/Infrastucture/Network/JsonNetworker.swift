//
//  Networker.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Combine
import Foundation

final class JsonNetworker: Networker {
    private let client: HTTPClient
    private let jsonDecoder: JSONDecoder
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
        self.jsonDecoder = JSONDecoder.postgresDateDecoder
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        client
            .send(endpoint.makeRequest())
            .tryMap { data, response in
                if 200..<300 ~= response.statusCode {
                    return data
                } else {
                    do {
                        let errorResponse = try self.jsonDecoder.decode(ErrorResponse.self, from: data)
                        throw PBError.server(errorResponse)
                    } catch {
                        throw PBError.network(error)
                    }
                }
            }
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { error -> Error in
                
                if let decodingError = error as? DecodingError {
                    return PBError.network(decodingError)
                }
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func requestImage(_ endpoint: Endpoint) -> AnyPublisher<Data, any Error> {
        fatalError("JsonNetworker does not support image loading requests")
    }
}
