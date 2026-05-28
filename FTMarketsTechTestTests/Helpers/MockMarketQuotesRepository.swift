//
//  MockMarketQuotesRepository.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation
@testable import FTMarketsTechTest

final class MockMarketQuotesRepository: MarketQuotesRepositoryInterface {

    var quotesToReturn: [MarketQuote] = []
    var errorToThrow: Error?

    func fetchQuotes() async throws -> [MarketQuote] {
        if let errorToThrow {
            throw errorToThrow
        }

        return quotesToReturn
    }
}
