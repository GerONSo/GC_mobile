//
//  OnboardingViewModel.swift
//  GC
//
//  Created by Sergey Goncharov on 17.12.2023.
//

import Foundation

class OnboardingViewModel : ObservableObject {
    @Published var state: OnboardingViewState
    private let api: Api
    
    private let DEFAULT_BUTTON_TEXT = "Register"
    private let DEFAULT_EMPTY_BUTTON_TEXT = ""
    
    init() {
        self.state = OnboardingViewState(
            login: "",
            password: "",
            name: "",
            showPassword: false,
            showProgress: false,
            buttonText: DEFAULT_BUTTON_TEXT,
            navigateShops: false
        )
        self.api = Api()
    }
    
    // Переключалка видимости пароля
    func toggleShowPassword() {
        state.showPassword.toggle()
    }
    
    // Пробуем зарегистрироваться
    func register() {
        state.showProgress = true
        state.buttonText = DEFAULT_EMPTY_BUTTON_TEXT
        if state.login.isEmpty || state.password.isEmpty || state.name.isEmpty {
            return
        } else {
            Task {
                let result = await api.register(user: OnboardingUserDto(
                    login: state.login,
                    password: state.password,
                    name: state.name
                ))
                DispatchQueue.main.async {
                    self.state.showProgress = false
                    self.state.buttonText = self.DEFAULT_BUTTON_TEXT
                    if (result?.token != nil) {
                        self.state.navigateShops = true
                    }
                }
            }
        }
    }
}


struct OnboardingViewState: Codable {
    var login: String
    var password: String
    var name: String
    var showPassword: Bool
    var showProgress: Bool
    var buttonText: String
    var navigateShops: Bool
}

