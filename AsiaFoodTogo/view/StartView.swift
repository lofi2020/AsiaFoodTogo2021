//
//  ContentView.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 02.02.21.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var appData = AppData.shared()
    var body: some View {
        TabView{
            NavigationView {
                HomeView()
                    .navigationBarItems(
                        leading:
                            NavigationLink(destination: NavigationDrawer(isOpen: true)) {
                                HStack {
                                    Image(systemName: "text.justify")
                                    Text(appData.store.name)
                                }
                            }
                        ,
                        trailing:
                            NavigationLink(destination: LoginView()) {
                                Image(systemName: "person.circle")
                            }
                        )
            }.tabItem {
               Image(systemName: "house")
               Text("Home")
            }
            NavigationView {
                CategoryListView().navigationBarTitle("Categories",displayMode: .inline)
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("Categories")
            }
            NavigationView {
                SearchView().navigationBarTitle("Search",displayMode: .inline)
            }.tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            NavigationView {
                CartView().navigationBarTitle("Cart",displayMode: .inline)
            }.tabItem {
                Image(systemName: "cart")
                Text(appData.cartTotal)
            }
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
