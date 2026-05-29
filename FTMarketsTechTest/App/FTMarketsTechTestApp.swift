//
//  FTMarketsTechTestApp.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import SwiftUI

@main
struct FTMarketsTechTestApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreenView(
                viewModel: MarketsViewModel(
                    useCase: GetMarketQuotesUseCase(
                        repository: MarketQuotesRepositoryImpl(
                            apiClient: APIClient(
                                requestBuilder: DefaultRequestBuilder(
                                    baseURL: URL(
                                        string: "https://markets-data-api-proxy.ft.com"
                                    )!
                                ),
                                session: URLSession.shared,
                                validator: DefaultResponseValidator(),
                                decoder: JSONResponseDecoder()
                            )
                        )
                    )
                )
            )
        }
    }
}
