//
//  QuotePriceDTO.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct QuotePriceDTO: Decodable, Sendable {
    let lastPrice: Double?
    let change1Day: Double?
    let change1DayPercent: Double?
    let timeStamp: String?
}
