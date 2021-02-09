//
//  Toast.swift
//  ToastMessageUI
//
//  Created by Lofi on 08.02.21.
//

import SwiftUI

struct Toast<Presenting, Content>: View where Presenting: View, Content: View {
    @Binding var isPresented: Bool
    let presenter: () -> Presenting
    let content: () -> Content
    let delay: TimeInterval = 1

    var body: some View {
        if self.isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                withAnimation {
                    self.isPresented = false
                }
            }
        }

        return GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.presenter()
                ZStack {
                    Capsule()
                        .fill(Color.white).opacity(0.95 )
                    self.content()
                } //ZStack (inner)
                .frame(width: geometry.size.width / 1.25, height: geometry.size.height / 10)
                .opacity(self.isPresented ? 1 : 0)
            } //ZStack (outer)
            .shadow(color: Color.black.opacity(0.4),
                    radius: 3,
                    x: 2,
                    y: 2)
        } //GeometryReader
    } //body
} //Toast


