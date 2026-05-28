//
//  MockAPIClient.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation
@testable import FTMarketsTechTest

final class MockAPIClient: APIClientProtocol {

    var responseToReturn: Data?
    var errorToThrow: Error?

    func send<T: Decodable>(
        _ endpoint: Endpoint
    ) async throws -> T {
        if let errorToThrow {
            throw errorToThrow
        }

        guard let responseToReturn else {
            throw APIError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: responseToReturn)
    }
    
}
