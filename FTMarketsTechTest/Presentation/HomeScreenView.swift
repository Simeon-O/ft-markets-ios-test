//
//  HomeScreenView.swift
//  FTMarketsTechTest
//
//  Created by Simeon O'Connor on 5/29/26.
//

import SwiftUI

struct HomeScreenView: View {
    
    @StateObject private var viewModel: MarketsViewModel
    
    init(viewModel: MarketsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle, .loading:
                Text("Loading")
            case .quotes(let quotes):
                ForEach(quotes) { quote in
                    MarketPillContainer(
                        name: quote.text,
                        value: quote.value,
                        textColor: .green)
                }
            case .error:
                Text("Error")
            }
        }
        .task {
            await viewModel.loadQuotes()
        }
        
    }
        
}

#Preview {
    
}
