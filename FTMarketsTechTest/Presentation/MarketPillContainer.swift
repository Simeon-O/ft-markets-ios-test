//
//  MarketPillContainer.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/29/26.
//

import SwiftUI

struct MarketPillContainer: View {
    
    let name: String
    let value: String
    let textColor: Color
    
    var body: some View {
        HStack {
            Text(name)
            MarketDataPill(value: value, textColor: textColor)
        }
    }
}

#Preview {
    MarketPillContainer(name: "FTSE 100", value: "0.34", textColor: .green)
}
