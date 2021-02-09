//
//  CartView.swift
//  AsiaFoodToGo2
//
//  Created by Lofi on 01.02.21.
//

import SwiftUI

struct CartView: View {
    
    var dm = CartDataController()

    @ObservedObject var appData = AppData.shared()
    @State private var showToast: Bool = false
    @State private var icon = ""
    @State private var messageText = ""
    
    var body: some View {
        List{
            Section(header: Text("Products")) {
                ForEach(self.appData.cart.products,id: \.product_id) { item in
                    ProductItemListRow(cartView: self, dm: self.dm, productItem: item)
                }
            }
            Section(header: Text("Totals")) {
                ForEach(self.appData.cart.totals,id: \.title) { item in
                    TotalListRow(total: item)
                }
                Spacer()
                Spacer()
            }
        } .overlay(Button(action: {}) {
            Text("Checkout")
                .padding()
                .font(.system(size: 24))
                .foregroundColor(Color.white)
                .frame(width: 250, height: 60)
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            
        }.disabled(appData.cartItemCount > 0),alignment: .bottom)
        .listStyle(GroupedListStyle())
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

struct ProductItemListRow: View {
  var cartView: CartView!
  let dm : CartDataController
  let productItem: ProductItem
  var body: some View {
        VStack(alignment: .leading) {
           HStack {
            Image(systemName: "photo.fill").data(url: URL(string: self.productItem.thumb)!).frame(width: 100.0, height: 100.0)
            VStack(alignment: .leading) {
                Text(self.productItem.name).fontWeight(.bold).font(.system(size: 20)).padding(.top, 0)
                Text(self.productItem.total).padding(.top, 10).font(.system(size: 20)) .foregroundColor(Color.gray)
                VStack {
                           HStack {
                               Image(systemName: "minus.circle").resizable().frame(width: 32, height:32).foregroundColor(Color.blue)
                                   .onTapGesture {
                                        var quantity = Int(self.productItem.quantity) ?? 0
                                        quantity = quantity - 1
                                    dm.editCart(key: self.productItem.cart_id, quantity: quantity ) { message in
                                        cartView.showMessage(message: message)
                                    }
                                   }.frame(width: 32, height: 32)
                               
                            Text(self.productItem.quantity).font(.system(size: 20))
                            Image(systemName: "plus.circle").resizable().frame(width: 32, height: 32)
                                .foregroundColor(Color.blue)
                                   .onTapGesture {
                                    var quantity = Int(self.productItem.quantity) ?? 0
                                    quantity = quantity + 1
                                    dm.editCart(key: self.productItem.cart_id, quantity: quantity ) { message in
                                        cartView.showMessage(message: message)
                                    }
                               }
                             Spacer()
                            Image(systemName: "trash").resizable().frame(width: 30, height: 30)
                                .foregroundColor(Color.red)
                                   .onTapGesture {
                                    dm.removeCart(key: self.productItem.cart_id) { message in
                                        cartView.showMessage(message: message)
                                    }
                               }
                           }
                       }
            }
                
       }
    }
    
  }
}

struct TotalListRow: View {
  let total: Total
  var body: some View {
    HStack {
        Text(self.total.title).fontWeight(.bold)
        Text(self.total.text)
    }
  }
}
