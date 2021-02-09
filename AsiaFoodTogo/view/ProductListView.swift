//
//  ProductListView.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 03.02.21.
//
import Foundation
import SwiftUI

struct ProductListView: View {
    var category_id = "0"
    @State var title = "Products"
    @ObservedObject var dm: ProductDataController = ProductDataController()
    
    var body: some View {
            List(self.dm.allData.products, id: \.product_id) { item in
                NavigationLink(destination: ProductDetailView(product_id : item.product_id)){
                    ProductListRow(product: item)
                }
            }.onAppear{
                self.dm.loadProducts(category_id: category_id)
            }
           .navigationTitle(title)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}


struct ProductListRow: View {
  let product: Product
  var body: some View {
    VStack(alignment: .leading) {
        HStack(alignment: .top){
            Image(systemName: "photo.fill").data(url: URL(string: self.product.thumb)!).frame(width: 100.0, height: 100.0)
            VStack(alignment: .leading){
            Text(product.name).font(.system(size: 20)).fontWeight(.bold)
                Text(product.description).lineLimit(1)
                Text(product.price).fontWeight(.bold).padding(.top, 10)
         }
       }
        
    }
  }
}
