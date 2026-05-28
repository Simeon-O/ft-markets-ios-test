//
//  RequestBuilding.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

protocol RequestBuilding: Sendable {
    func makeRequest(from endpoint: Endpoint) throws -> URLRequest
}
