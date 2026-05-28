//
//  MarketQuotesRepositoryImpl.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

protocol MarketQuotesRepositoryInterface {
    func fetchQuotes() async throws -> [MarketQuote]
}

final class MarketQuotesRepositoryImpl: MarketQuotesRepositoryInterface {
    
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchQuotes() async throws -> [MarketQuote] {
        let response =
            try await apiClient.send(
                QuotesEndpoint()
            ) as QuotesResponseDTO

        return response.data.items.map {
            $0.toDomain()
        }
    }
    
}
