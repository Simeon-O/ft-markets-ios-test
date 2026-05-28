//
//  APIClient.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

final class APIClient: APIClientProtocol {

    private let requestBuilder: RequestBuilding
    private let session: NetworkSession
    private let validator: ResponseValidating
    private let decoder: ResponseDecoding

    init(
        requestBuilder: RequestBuilding,
        session: NetworkSession,
        validator: ResponseValidating,
        decoder: ResponseDecoding
    ) {
        self.requestBuilder = requestBuilder
        self.session = session
        self.validator = validator
        self.decoder = decoder
    }

    func send<T: Decodable & Sendable>(_ endpoint: Endpoint) async throws -> T {
        let request = try requestBuilder.makeRequest(from: endpoint)
        let (data, response) = try await session.data(for: request)
        try validator.validate(response)
        return try decoder.decode(T.self, from: data)
    }
}
