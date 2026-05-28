//
//  MarketQuote.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct MarketQuote {
    let symbol: String
    let name: String
    let price: Double?
    let percentageChange: Double?
}

extension QuoteDTO {
    func toDomain() -> MarketQuote {
        MarketQuote(
            symbol: basic.symbol,
            name: basic.name,
            price: quote.lastPrice,
            percentageChange: quote.change1DayPercent
        )
    }
}
