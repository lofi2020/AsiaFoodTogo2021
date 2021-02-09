//
//  CategoryListView.swift
//  AsiaFoodToGo2
//
//  Created by Lofi on 01.02.21.
//
import Foundation
import SwiftUI

struct CategoryListView: View {
    @ObservedObject var dm: CategoryDataController = CategoryDataController()
    var body: some View {
        List(self.dm.allData.categories, id: \.categoryID) { item in
            NavigationLink(destination: ProductListView(category_id: item.categoryID, title: item.name)){
                CategoryListRow(category: item)
            }
        }.onAppear{
            self.dm.loadCategories()
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}

struct CategoryListRow: View {
  let category: Category
  var body: some View {
    VStack(alignment: .leading) {
       HStack {
        Image(systemName: "photo.fill").data(url: URL(string: self.category.thumb)!).frame(width: 80.0, height: 80.0)
            Text(category.name)
       }
    }
  }
}

