//
//  OnboardingView.swift
//  GC
//
//  Created by Sergey Goncharov on 17.12.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            NavigationLink(
                destination: ShopsView().navigationBarBackButtonHidden(true),
                isActive: $viewModel.state.navigateShops
            ) { EmptyView() }
            Spacer()
            TextField("Login",
                      text: $viewModel.state.login,
                      prompt: Text("Login").foregroundColor(.black))
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            }
            .padding(.horizontal)
            
            TextField("Name",
                      text: $viewModel.state.name,
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
                        .overlay {
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.toggleShowPassword()
                                } label: {
                                    Image(systemName: viewModel.state.showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.black)
                                        .padding(.trailing)
                                }
                            }
                        }
                }
                
            }.padding(.horizontal)
            
            
            Button {
                viewModel.register()
            } label: {
                Text(viewModel.state.buttonText).foregroundColor(.white)
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
            
            Spacer()
        }
        .padding()
    }

}

#Preview {
    OnboardingView()
}
