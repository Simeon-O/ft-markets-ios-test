//
//  GetMarketQuotesUseCase.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

protocol UseCase {
    associatedtype Output
    func execute() async throws -> Output
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
