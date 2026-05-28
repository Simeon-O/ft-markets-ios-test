//
//  GetMarketQuotesUseCaseTests.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Testing
@testable import FTMarketsTechTest

struct GetMarketQuotesUseCaseTests {

    @Test
    func execute_returnsQuotesFromRepository() async throws {
        let repository = MockMarketQuotesRepository()
        repository.quotesToReturn = [
            MarketQuote(
                symbol: "FTSE:FSI",
                name: "FTSE 100 Index",
                price: 10495.46,
                percentageChange: 0.0387
            )
        ]

        let sut = await GetMarketQuotesUseCase(repository: repository)
        let quotes = try await sut.execute()
        #expect(quotes.count == 1)
        await #expect(quotes.first?.symbol == "FTSE:FSI")
        await #expect(quotes.first?.name == "FTSE 100 Index")
    }

    @Test
    func execute_propagatesRepositoryError() async {
        let repository = MockMarketQuotesRepository()
        repository.errorToThrow = APIError.invalidResponse
        let sut = await GetMarketQuotesUseCase(repository: repository)
        await #expect(throws: APIError.invalidResponse) {
            _ = try await sut.execute()
        }
    }
    
}
