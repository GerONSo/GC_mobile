//
//  MainView.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var router = Router.shared
    
    var body: some View {
        NavigationStack(path: $router.path) {
            if (Storage.userToken != "") {
                ShopsView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
