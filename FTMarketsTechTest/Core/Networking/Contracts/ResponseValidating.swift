//
//  ResponseValidating.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

protocol ResponseValidating: Sendable {
    func validate(_ response: URLResponse) throws
}
