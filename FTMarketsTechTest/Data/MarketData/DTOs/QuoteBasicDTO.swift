//
//  QuoteBasicDTO.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct QuoteBasicDTO: Decodable, Sendable {
    let symbol: String
    let name: String
    let exchange: String?
    let currency: String?
}
