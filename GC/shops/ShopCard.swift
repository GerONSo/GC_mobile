//
//  ShopCard.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import SwiftUI

struct ShopCard: View {
    var shop: ShopCardViewState

    var body: some View {
        HStack {
            VStack {
                AsyncImage(url: URL(string: shop.imageUrl)) { image in
                    image
                        .image?.resizable()
                }
                .scaledToFill()
                .frame(height: 300)
                .frame(minWidth: 0, maxWidth: .infinity)
                .clipped()
                HStack {
                    Text(shop.title)
                        .font(.title3)
                        .padding(.leading, 20)
                        .bold()
                    
                    Spacer()
                    
                    
                }
                
                HStack {
                    Text(shop.address)
                        .font(.caption)
                        .padding(.leading, 20)
                    Spacer()
                }
                
                HStack {
                    Text("Only \(shop.ordersLeft) left!")
                        .padding(.leading, 20)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .bold()
                    
                    Spacer()
                    
                    Text("€\(shop.price)")
                        .frame(width: 100)
                        .font(.title)
                        .padding(.horizontal)
                }
            }
        }
        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
        .padding(.bottom, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
    }
}

struct ShopCardViewState: Identifiable {
    var title: String
    var address: String
    var ordersLeft: String
    var active: Bool
    var price: String
    var shopId: String
    var imageUrl: String
    let id = UUID()
}


#Preview {
    ShopCard(shop: ShopCardViewState(
        title: "Coffin coffee",
        address: "Moscow, Novocheremushkinskaya",
        ordersLeft: "10",
        active: true,
        price: "15",
        shopId: "1",
        imageUrl: "https://storage.yandexcloud.net/gc-images/shops/photo_2023-12-18_19-22-09.jpg"
    ))
}
