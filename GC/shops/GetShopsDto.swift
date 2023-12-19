//
//  GetShopsDto.swift
//  GC
//
//  Created by Sergey Goncharov on 17.12.2023.
//

import Foundation

struct GetShopsResponseDto: Codable {
    var shops: [GetShopsShopResponseDto]
}


struct GetShopsShopResponseDto: Codable {
    var id: String
    var name: String
    var address: String
    var ordersLeft: Int
    var price: String
    var imageUrl: String
    
    private enum CodingKeys : String, CodingKey {
        case id, name, address, ordersLeft = "orders_left", price, imageUrl = "image_url"
    }
}
