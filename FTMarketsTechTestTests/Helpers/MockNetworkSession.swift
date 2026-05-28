//
//  MockNetworkSession.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation
@testable import FTMarketsTechTest

final class MockNetworkSession: NetworkSession {

    var receivedRequest: URLRequest?

    var dataToReturn: Data = Data()
    var responseToReturn: URLResponse = HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!

    var errorToThrow: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        receivedRequest = request

        if let errorToThrow {
            throw errorToThrow
        }

        return (dataToReturn, responseToReturn)
    }
}
