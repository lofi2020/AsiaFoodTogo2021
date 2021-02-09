//
//  HomeView.swift
//  AsiaFoodToGo2
//
//  Created by Lofi on 01.02.21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var appData = AppData.shared()
    @State var remoteImage: RemoteImage!
    
    var body: some View {
        VStack {
            remoteImage?.frame(width: 300.0, height: 80.0)
            Text(self.appData.store.name).font(.title)
            Text(self.appData.store.address)
            Text(self.appData.store.telephone)
            Text(self.appData.store.fax)
            Text(self.appData.store.storeOpen).padding(.top, 10)
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
                
        ).padding()
        .onAppear() {
                if (!self.appData.store.logo.isEmpty) {
                    remoteImage = RemoteImage(url: URL(string: self.appData.store.logo)!)
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
