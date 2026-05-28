//
//  QuoteDTO.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct QuoteDTO: Decodable, Sendable {
    let symbolInput: String
    let basic: QuoteBasicDTO
    let quote: QuotePriceDTO
}
