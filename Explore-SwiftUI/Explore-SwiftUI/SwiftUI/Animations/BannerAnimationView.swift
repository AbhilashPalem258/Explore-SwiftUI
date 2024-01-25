//
//  BannerAnimationView.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/07/22.
//

import Foundation
import SwiftUI

struct BannerAnimationView: View {
    
    @State var selection: Int = 0
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.5).ignoresSafeArea()
            
            TabView(selection: $selection) {
                Rectangle()
                    .foregroundColor(.red)
//                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .tag(1)
                
                Rectangle()
                    .foregroundColor(.green)
//                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .tag(2)
                
                Rectangle()
                    .foregroundColor(.blue)
//                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .tag(3)
                
                Rectangle()
                    .foregroundColor(.purple)
//                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 200)
        }
        .onReceive(timer) { value in
            withAnimation(.easeInOut) {
                selection = selection > 4 ? 1 : selection + 1
            }
        }
    }
}

struct BannerAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BannerAnimationView()
    }
}
