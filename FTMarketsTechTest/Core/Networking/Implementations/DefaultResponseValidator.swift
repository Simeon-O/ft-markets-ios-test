//
//  DefaultResponseValidator.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct DefaultResponseValidator: ResponseValidating {
    func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}
