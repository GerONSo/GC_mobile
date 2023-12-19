//
//  ShopDetailsView.swift
//  GC
//
//  Created by Sergey Goncharov on 17.12.2023.
//

import SwiftUI

struct ShopDetailsView: View {
    @ObservedObject
    var viewModel: ShopDetailsViewModel
    
    init(shopId: String) {
        self.viewModel = ShopDetailsViewModel(shopId: shopId)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: viewModel.state.imageUrl)) { image in
                    image
                        .image?.resizable()
                }
                .scaledToFill()
                .frame(height: 300)
                .frame(minWidth: 0, maxWidth: .infinity)
                .clipped()
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .frame(width: 90, height: 40)
                                .overlay {
                                    Text(viewModel.state.ordersLeftString)
                                        .font(.caption2)
                                        .padding(.top, 2)
                                        .foregroundColor(Color("red"))
                                        .bold()
                                }
                            
                        }
                        Spacer()
                    }.padding()
                }
                
                Text(viewModel.state.title)
                    .font(.title)
                    .padding(.top, 20)
                    .bold()
                
                HStack {
                    Text(viewModel.state.description)
                        .font(.caption)
                }.padding(.horizontal, 30).padding(.top, 10)
                
                HStack {
                    Text(viewModel.state.address)
                        .font(.caption)
                        .padding(.leading, 30)
                        .padding(.top, 10)
                        .bold()
                    Spacer()
                }
                
                HStack {
                    Text(viewModel.state.time)
                        .font(.caption)
                        .padding(.top, 2)
                        .bold()
                        .padding(.leading, 30)
                    
                    Spacer()
                }
                
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.order()
                    } label: {
                        Text(viewModel.state.buttonOrderText).foregroundColor(.white)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .padding(12)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                    }
                    .padding(.horizontal)
                    .overlay {
                        if viewModel.state.showProgress {
                            ProgressView().tint(.white)
                        }
                    }
                    HStack {
                        Button {
                            viewModel.decCount()
                        } label: {
                            Text("-").font(.title).foregroundColor(.black)
                        }.padding(.trailing, 25)
                        
                        Text(String(viewModel.state.orderCount)).frame(width: 23)
                        
                        Button {
                            viewModel.addCount()
                        } label: {
                            Text("+").font(.title).foregroundColor(.black)
                        }.padding(.leading, 25)
                    }.visibility(viewModel.state.footerVisibility)
                }.padding(.top, 20).padding(.trailing, 30)
                Spacer()
            }
        }
    }
}

#Preview {
    ShopDetailsView(shopId: "1")
}
