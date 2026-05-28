//
//  MarketQuotesRepositoryTests.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation
import Testing
@testable import FTMarketsTechTest

struct MarketQuotesRepositoryTests {

    @Test
    func fetchQuotes_returnsMappedDomainModels() async throws {
        let apiClient = MockAPIClient()
        apiClient.responseToReturn = try TestJSON.data(named: "market_quotes_success")
        let sut = await MarketQuotesRepositoryImpl(apiClient: apiClient)
        let quotes = try await sut.fetchQuotes()

        #expect(quotes.count == 2)
        await #expect(quotes.first?.symbol == "FTSE:FSI")
        await #expect(quotes.first?.name == "FTSE 100 Index")
        await #expect(quotes.first?.price == 10495.46)
        await #expect(quotes.first?.percentageChange == 0.0387)
    }

    @Test
    func fetchQuotes_preservesMissingValuesAsNil() async throws {
        let apiClient = MockAPIClient()
        apiClient.responseToReturn = try TestJSON.data(named: "market_quotes_missing_values")
        let sut = await MarketQuotesRepositoryImpl(apiClient: apiClient)
        let quotes = try await sut.fetchQuotes()
        #expect(quotes.count == 1)
        await #expect(quotes.first?.symbol == "GBPUSD")
        await #expect(quotes.first?.price == nil)
        await #expect(quotes.first?.percentageChange == nil)
    }

    @Test
    func fetchQuotes_propagatesAPIError() async {
        let apiClient = MockAPIClient()
        apiClient.errorToThrow = APIError.serverError(statusCode: 500)
        let sut = await MarketQuotesRepositoryImpl(apiClient: apiClient)
        await #expect(throws: APIError.serverError(statusCode: 500)) {
            _ = try await sut.fetchQuotes()
        }
    }
    
}
