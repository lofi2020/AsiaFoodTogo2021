//
//  NavigationDrawer.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 04.02.21.
//

import SwiftUI

struct NavigationDrawer: View {
    private let width = UIScreen.main.bounds.width - 100
    let isOpen: Bool
    
    var body: some View {
        HStack {
            DrawerContent()
                .frame(width: self.width)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.default)
            Spacer()
        }
    }
}

struct NavigationDrawer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDrawer(isOpen: false)
    }
}

struct DrawerContent: View {
    var body: some View {
        Color.blue
    }
}
