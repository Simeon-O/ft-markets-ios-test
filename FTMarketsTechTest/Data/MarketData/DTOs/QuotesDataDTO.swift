//
//  QuotesDataDTO.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct QuotesDataDTO: Decodable, Sendable {
    let items: [QuoteDTO]
}
