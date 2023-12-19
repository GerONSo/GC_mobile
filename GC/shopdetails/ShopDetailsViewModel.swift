//
//  ShopDetailsViewModel.swift
//  GC
//
//  Created by Sergey Goncharov on 18.12.2023.
//

import Foundation
import os

class ShopDetailsViewModel: ObservableObject {
    @Published var state: ShopDetailsViewState
    private let api: Api
    private let logger = Logger()
    private var shopId: String = ""
    
    init(shopId: String) {
        self.state = ShopDetailsViewState(
            title: "",
            ordersLeft: 0,
            ordersLeftString: "",
            description: "",
            address: "",
            time: "",
            buttonOrderText: "Order",
            orderCount: 1,
            price: 15,
            imageUrl: "",
            showProgress: false,
            footerVisibility: .visible
        )
        self.api = Api()
        self.shopId = shopId
        getShop(id: shopId)
    }
    
    // Прибавление счетчика количества заказов
    func addCount() {
        if (state.orderCount < state.ordersLeft) {
            state.orderCount += 1
        }
        recalcButtonText()
    }
    
    // Убавление счетчика количества заказов
    func decCount() {
        if state.orderCount > 1 {
            state.orderCount -= 1
        }
        recalcButtonText()
    }
    
    // Пересчитываем текст на кнопке в зависимости от количества заказов и цены
    func recalcButtonText() {
        state.buttonOrderText = if (state.ordersLeft > 0) {
            "Order for €\(state.price * Float(state.orderCount))"
        } else {
            "Cannot order right now"
        }
    }
    
    // Отправляем запрос на заказ
    func order() {
        if state.orderCount == 0 {
            return
        }
        Task {
            let result = await api.order(shopId: self.shopId, orderNumber: String(state.orderCount))
            if (result != nil) {
                getShop(id: shopId)
            }
        }
    }
    
    // Отправляем запрос о данных магазина
    func getShop(id: String) {
        self.state.showProgress = true
        Task {
            let result = await api.getShop(id: id)
            if (result == nil) {
                return
            }
            let price = Float(result!.price)
            if (price == nil) {
                return
            }
            let visibility = if (result!.ordersLeft == 0) {
                ViewVisibility.gone
            } else {
                ViewVisibility.visible
            }
            let ordersLeft = if (result!.ordersLeft > 0) {
                "Only \(result!.ordersLeft) left!"
            } else {
                "No orders left"
            }
            
            DispatchQueue.main.async {
                self.state = ShopDetailsViewState(
                    title: result!.name,
                    ordersLeft: result!.ordersLeft,
                    ordersLeftString: ordersLeft,
                    description: result!.description,
                    address: result!.address,
                    time: TimeParser.parse(time: result!.activeTime),
                    buttonOrderText: "Order",
                    orderCount: 1,
                    price: price!,
                    imageUrl: result!.imageUrl,
                    showProgress: false,
                    footerVisibility: visibility
                )
                self.recalcButtonText()
            }
        }
    }
}

struct ShopDetailsViewState {
    var title: String
    var ordersLeft: Int
    var ordersLeftString: String
    var description: String
    var address: String
    var time: String
    var buttonOrderText: String
    var orderCount: Int
    var price: Float
    var imageUrl: String
    var showProgress: Bool
    var footerVisibility: ViewVisibility
}
