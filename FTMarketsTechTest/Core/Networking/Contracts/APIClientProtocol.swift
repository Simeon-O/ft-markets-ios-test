//
//  APIClientProtocol.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

protocol APIClientProtocol {
    func send<T: Decodable & Sendable>(_ endpoint: Endpoint) async throws -> T
}
