//
//  QuotesEndpoint.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

struct QuotesEndpoint: Endpoint {

    let path = "/research/webservices/securities/v1/quotes"

    let queryItems = [
        URLQueryItem(
            name: "symbols",
            value: "FTSE:FSI,INX:IOM,EURUSD,GBPUSD,IB.1:IEU"
        )
    ]
}
