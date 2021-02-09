//
//  ProductDetailView.swift
//  AsiaFoodToGo2
//
//  Created by Lofi on 01.02.21.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product_id: String!
    @ObservedObject var productDm: ProductDataController = ProductDataController()
    @ObservedObject var cartDm: CartDataController = CartDataController()
    @State var remoteImage: RemoteImage!
    
    @State private var showToast: Bool = false
    @State private var icon = ""
    @State private var messageText = ""
    
    var body: some View {
        VStack(alignment: .leading){
            remoteImage?.frame(width: 300, height: 200.0)
            Text(self.productDm.product.name).font(.system(size: 30)).fontWeight(.bold).padding(.top, 10)
            Text(self.productDm.product.description).padding(.top, 10)
            Text(self.productDm.product.price).fontWeight(.bold).padding(.top, 10)
            Spacer()
            Spacer()
            Spacer()
        }.padding(.bottom, 20)
        .frame(minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                )
        .onAppear() {
            self.productDm.loadProduct(product_id: self.product_id) {
                remoteImage = RemoteImage(url: URL(string: self.productDm.product.thumb)!)
            }
        }
        .padding()
        .navigationTitle(self.productDm.product.name)
        .overlay(
                    Button(action: {
                        self.cartDm.addToCart(product_id: self.product_id) { message in
                            self.showMessage(message: message)
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "cart.fill.badge.plus")
                            Text("Add to Cart")
                        }.font(.system(size: 24))
                        .foregroundColor(Color.white)
                    })
                    .frame(width: 250, height: 60)
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3),
            alignment: .bottom
        )
        .toast(isPresented: self.$showToast) {
            HStack {
                Image(systemName: self.icon)
                Text(self.messageText)
            }
        } //toast

    }
    
    public func showMessage(message: ResponseDTO) {
        if(!message.success!.isEmpty) {
            self.icon =  "checkmark.circle"
            self.messageText = message.success!
        } else if (!message.error!.isEmpty) {
            self.icon = "multiply.circle"
            self.messageText = message.error!
        } else {
            self.icon = "exclamationmarktriangle"
            self.messageText = message.warning!
        }
        self.showToast = true
    }
    
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
