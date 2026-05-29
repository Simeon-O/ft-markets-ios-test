//
//  MarketsViewModel.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation
import Combine

@MainActor
final class MarketsViewModel: ObservableObject {
    
    private let useCase: GetMarketQuotesUseCase
    
    @Published var state: State = .idle
    
    enum State {
        case idle
        case loading
        case quotes([MarketQuoteViewData])
        case error
    }
    
    init(useCase: GetMarketQuotesUseCase) {
        self.useCase = useCase
    }
    
    func loadQuotes() async {
        self.state = .loading
        
        do {
            let quotes = try await Task.detached { try await self.useCase.execute() }.value
            let viewData = quotes.map { MarketQuoteViewData(quote: $0) }
            self.state = .quotes(viewData)
        } catch {
            
            self.state = .error
            
        }
    }
    
    
    
}

struct MarketQuoteViewData: Identifiable {
    let id: String
    let text: String
    let value: String
    let trend: Trend
    
    init(quote: MarketQuote) {
        self.id = quote.symbol
        self.text = quote.name
        self.value = quote.percentageChange?.description ?? ""
        self.trend = (quote.percentageChange ?? 0) > 0 ? .positive : .negative
    }
    
    enum Trend {
        case positive
        case negative
    }
    
}
