//
//  ShopsViewModel.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import Foundation
import os

class ShopsViewModel : ObservableObject {
    
    @Published var state: ShopsViewState
    private let api: Api
    
    init() {
        self.state = ShopsViewState(shops: [], navigateDetails: false)
        self.api = Api()
        getShops()
    }
    
    // Пробуем запросить список всех магазинов
    func getShops() {
        Task {
            let result = await api.getShops()
            Logger().debug("\(result!.shops[0].ordersLeft)")
            DispatchQueue.main.sync {
                self.state.shops = result?.shops.map { shop in
                    ShopCardViewState(
                        title: shop.name,
                        address: shop.address,
                        ordersLeft: String(shop.ordersLeft),
                        active: true,
                        price: shop.price,
                        shopId: shop.id,
                        imageUrl: shop.imageUrl
                    )
                } ?? []
            }
        }
    }
    
}

struct ShopsViewState {
    var shops: [ShopCardViewState]
    var navigateDetails: Bool
}
