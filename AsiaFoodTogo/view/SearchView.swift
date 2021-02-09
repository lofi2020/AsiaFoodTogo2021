//
//  SearchView.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 02.02.21.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    @ObservedObject var dm: ProductDataController = ProductDataController()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, dm: dm)
            List(self.dm.allData.products, id: \.product_id) { item in
                NavigationLink(destination: ProductDetailView(product_id : item.product_id)){
                    ProductListRow(product: item)
                }
            }
        }
        .padding(.top, 10)
        .onAppear() {
            dm.loadProducts(search: "")
        }
            
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    var dm: ProductDataController = ProductDataController()
    
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                    dm.loadProducts(search: self.text)
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    dm.loadProducts(search: self.text)
                }) {
                    Image(systemName: "multiply.circle").foregroundColor(Color.red).font(.system(size: 24, weight: .medium))
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            Button(action: {
                dm.loadProducts(search: self.text)
            }) {
                Image(systemName: "magnifyingglass.circle").foregroundColor(Color.blue).font(.system(size: 24, weight: .medium))
            }
        }
    }
}

