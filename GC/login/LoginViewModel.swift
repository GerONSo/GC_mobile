//
//  LoginViewModel.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import Foundation
import SwiftUI
import os

class LoginViewModel : ObservableObject {
    @Published var state: LoginViewState
    private let api: Api
    
    private let DEFAULT_LOGIN_BUTTON_TEXT = "Sign in"
    private let DEFAULT_REGISTER_BUTTON_TEXT = "Register"
    private let DEFAULT_EMPTY_BUTTON_TEXT = ""
    
    init() {
        self.state = LoginViewState(
            login: "",
            password: "",
            showPassword: false,
            showProgress: false,
            loginButtonText: DEFAULT_LOGIN_BUTTON_TEXT,
            registerButtonText: DEFAULT_REGISTER_BUTTON_TEXT,
            navigateOnboarding: false,
            navigateShops: false
        )
        self.api = Api()
        Logger().debug("\(Storage.userToken)")
    }
    
    // Переключалка видимости пароля
    func toggleShowPassword() {
        state.showPassword.toggle()
    }
    
    // Пробуем авторизоваться
    func login() {
        state.showProgress = true
        state.loginButtonText = DEFAULT_LOGIN_BUTTON_TEXT
        Task {
            let result = await api.login(user: LoginUserDto(login: state.login, password: state.password))
            DispatchQueue.main.async {
                self.state.showProgress = false
                self.state.loginButtonText = self.DEFAULT_LOGIN_BUTTON_TEXT
                if (result?.token != nil) {
                    self.state.navigateShops = true
                }
                Storage.userToken = result!.token
            }
        }
    }
    
    // Навигируемся на регистрацию
    func register() {
        state.navigateOnboarding = true
    }
}


struct LoginViewState: Codable {
    var login: String
    var password: String
    var showPassword: Bool
    var showProgress: Bool
    var loginButtonText: String
    var registerButtonText: String
    var navigateOnboarding: Bool
    var navigateShops: Bool
}
