//
//  MarketDataPill.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/29/26.
//

import SwiftUI

struct MarketDataPill: View {
    let value: String
    let textColor: Color
    
    var body: some View {
        Text(value)
            .foregroundStyle(textColor)
    }
}

#Preview {
    MarketDataPill(value: "0.58", textColor: .red)
}
