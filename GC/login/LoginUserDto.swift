//
//  LoginUserDto.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import Foundation

struct LoginUserDto: Codable {
    var login: String
    var password: String
}

struct LoginResponseDto: Codable {
    var token: String
}
