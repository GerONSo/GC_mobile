//
//  Api.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import Foundation
import os

class Api {
    
    private let host = "https://api.pearlerclub.com/GC/v1/"
    private let logger = Logger()
    
    func login(user: LoginUserDto) async -> LoginResponseDto? {
        let path = "user/auth"
        let data = encode(item: user)
        if data == nil {
            return nil
        }
        return await send(path: path, data: data!, httpMethod: .POST)
    }
    
    func register(user: OnboardingUserDto) async -> OnboardingResponseDto? {
        let path = "user/create"
        let data = encode(item: user)
        if data == nil {
            return nil
        }
        return await send(path: path, data: data!, httpMethod: .POST)
    }
    
    func getShops() async -> GetShopsResponseDto? {
        let path = "view/main_page"
        return await send(path: path, data: nil, httpMethod: .GET)
    }
    
    func getShop(id: String) async -> ShopDetailsResponseDto? {
        let path = "view/shop"
        let query = [
            URLQueryItem(name: "shop_id", value: id)
        ]
        return await send(path: path, data: nil, httpMethod: .GET, queryItems: query)
    }
    
    func order(shopId: String, orderNumber: String) async -> ShopDetailsOrderResponse? {
        let path = "/order/create"
        let query = [
            URLQueryItem(name: "shop_id", value: shopId),
            URLQueryItem(name: "order_number", value: orderNumber)
        ]
        return await send(path: path, data: nil, httpMethod: .POST, queryItems: query)
    }
    
    // =================================================
    
    private func encode<T: Codable>(item: T) -> Data? {
        do {
            return try JSONEncoder().encode(item)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    private func send<T: Codable>(path: String, data: Data?, httpMethod: HttpMethod, token: String? = nil, queryItems: [URLQueryItem] = []) async -> T? {
        let url = host + path
        var components = URLComponents(string: url)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if (token != nil) {
            request.setValue(token!, forHTTPHeaderField: "User-Token")
        }
        request.httpMethod = httpMethod.rawValue
        do {
            if (data != nil) {
                let (resultData, _) = try await URLSession.shared.upload(for: request, from: data!)
                return try JSONDecoder().decode(T.self, from: resultData)
            } else {
                let (resultData, _) = try await URLSession.shared.data(for: request)
                return try JSONDecoder().decode(T.self, from: resultData)
            }
        } catch let error {
            logger.debug("\(error.localizedDescription)")
            return nil
        }
    }
    
    private enum HttpMethod: String {
        case POST = "POST"
        case GET = "GET"
    }
}
