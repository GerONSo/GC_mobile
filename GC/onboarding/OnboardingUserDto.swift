//
//  OnboardingUserDto.swift
//  GC
//
//  Created by Sergey Goncharov on 17.12.2023.
//

import Foundation

struct OnboardingUserDto: Codable {
    var login: String
    var password: String
    var name: String
}

struct OnboardingResponseDto: Codable {
    var token: String
}
