//
//  DefaultRequestBuilder.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct DefaultRequestBuilder: RequestBuilding {

    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func makeRequest(from endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        guard let url = components?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        endpoint.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
