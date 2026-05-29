//
//  GetMarketQuotesUseCase.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

protocol UseCase {
    func execute() async throws -> [MarketQuote]
}

final class GetMarketQuotesUseCase: UseCase {
    private let repository: MarketQuotesRepositoryInterface
    init(repository: MarketQuotesRepositoryInterface) {
        self.repository = repository
    }
    func execute() async throws -> [MarketQuote] {
        try await repository.fetchQuotes()
    }
}
