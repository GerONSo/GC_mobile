//
//  ShopDetailsDto.swift
//  GC
//
//  Created by Sergey Goncharov on 18.12.2023.
//

import Foundation

struct ShopDetailsResponseDto: Codable {
    var id: String
    var name: String
    var description: String
    var address: String
    var ordersLeft: Int
    var price: String
    var imageUrl: String
    var activeTime: ShopDetailsResponseActiveTime
    
    private enum CodingKeys : String, CodingKey {
        case id, name, description, address, ordersLeft = "orders_left", price, imageUrl = "image_url", activeTime = "active_time"
    }
}

struct ShopDetailsResponseActiveTime: Codable {
    var start: String
    var finish: String
}

struct ShopDetailsOrderResponse: Codable {
    
}
