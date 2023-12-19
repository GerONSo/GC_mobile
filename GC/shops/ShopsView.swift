//
//  ShopsView.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import SwiftUI
import os

struct ShopsView: View {
    @ObservedObject private var viewModel: ShopsViewModel
    
    init() {
        viewModel = ShopsViewModel()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($viewModel.state.shops, id: \.id) { $shop in
                        ShopCard(shop: shop)
                            .listRowSeparator(.hidden)
                            .overlay {
                                NavigationLink(
                                    destination: ShopDetailsView(shopId: shop.shopId)) {
                                        EmptyView().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    }
                            }
                    }
                }
                .onAppear {
                    viewModel.getShops()
                }
                .scrollContentBackground(.hidden)
                .frame(minWidth: 0, maxWidth: .infinity)
                .listStyle(InsetListStyle())
            }.navigationTitle("All shops")
                
        }
    }
}

#Preview {
    ShopsView()
}
