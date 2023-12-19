//
//  LoginView.swift
//  GC
//
//  Created by Sergey Goncharov on 16.12.2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            NavigationLink(destination: OnboardingView(), isActive: $viewModel.state.navigateOnboarding) { EmptyView()
            }
            NavigationLink(
                destination: ShopsView().navigationBarBackButtonHidden(true),
                isActive: $viewModel.state.navigateShops
            ) { EmptyView() }
            Spacer()
            TextField("Login",
                      text: $viewModel.state.login,
                      prompt: Text("Name").foregroundColor(.black))
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack {
                Group {
                    if viewModel.state.showPassword {
                        TextField("Password",
                                  text: $viewModel.state.password,
                                  prompt: Text("Password").foregroundColor(.black)
                        )
                    } else {
                        SecureField("Password",
                                    text: $viewModel.state.password,
                                    prompt: Text("Password").foregroundColor(.black)
                        )
                    }
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                }
                
                Button {
                    viewModel.toggleShowPassword()
                } label: {
                    Image(systemName: viewModel.state.showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.black)
                }
                
            }.padding(.horizontal)
            
            Button {
                viewModel.login()
            } label: {
                Text(viewModel.state.loginButtonText).foregroundColor(.white)
            }
            .frame(width: 100)
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 10)
            }
            .padding(.horizontal)
            .overlay {
                if viewModel.state.showProgress {
                    ProgressView().tint(.white)
                }
            }
            
            Button {
                viewModel.register()
            } label: {
                Text("Register").foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
