//
//  QuotesResponseDTO.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

nonisolated struct QuotesResponseDTO: Decodable, Sendable {
    let data: QuotesDataDTO
    let timeGenerated: String
}
