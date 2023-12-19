//
//  Router.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()

    static let shared: Router = Router()
}


struct Routes {
    static let LOGIN = "LOGIN"
    static let SHOPS = "SHOPS"
    static let ONBOARDING = "ONBOARDING"
}
