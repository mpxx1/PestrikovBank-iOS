//
//  NetworkDIContainer.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Foundation

final class NetworkerDIContainer {
    
    func httpClient() -> HTTPClient {
        return URLSessionHTTPClient()
    }
    
    func jsonNetworker() -> Networker {
        return JsonNetworker(client: httpClient())
    }
    
    func pngNetworker() -> Networker {
        return PngNetworker(client: httpClient())
    }
    
    func makeJsonEndpoint(encoded: Data, path: String) -> Endpoint {
        return Endpoint(
            baseURL: URL(string: AppConfig.apiBaseURL())!,
            path: path,
            method: .POST,
            headers: ["Content-Type": "application/json", "Content-Length":"\(encoded.count)"],
            body: encoded
        )
    }
}
