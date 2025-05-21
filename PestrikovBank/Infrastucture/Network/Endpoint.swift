//
//  Endpoint.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
}

public struct Endpoint {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data
    
    func makeRequest() -> URLRequest {
        var req = URLRequest(url: baseURL.appendingPathComponent(path))
        req.httpMethod = method.rawValue
        headers.forEach { req.setValue($0.value, forHTTPHeaderField: $0.key) }
        req.httpBody = body
        return req
    }
}
