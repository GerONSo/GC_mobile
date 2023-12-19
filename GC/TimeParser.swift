//
//  TimeParser.swift
//  GC
//
//  Created by Sergey Goncharov on 19.12.2023.
//

import Foundation

class TimeParser {
    
    static func parse(time: ShopDetailsResponseActiveTime) -> String {
        return "Open from \(time.start) to \(time.finish)"
    }
}
