//
//  MenuToCrossicon.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 28/12/22.
//

import SwiftUI

// https://www.youtube.com/watch?v=duBGN8vD8g4
struct MenuToCrossicon: View {
    
    @State private var isMenu = false
    
    var body: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 64, height: 10)
                .rotationEffect(Angle(degrees: isMenu ? 0 : 48), anchor: .leading)
//                .animation(.easeInOut, value: isMenu)
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 64, height: 10)
                .scaleEffect(isMenu ? 1.0 : 0.0, anchor: .leading)
//                .animation(.easeInOut, value: isMenu)
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 64, height: 10)
                .rotationEffect(Angle(degrees: isMenu ? 0 : -48), anchor: .leading)
//                .animation(.easeInOut, value: isMenu)
        }
        .padding()
        .onTapGesture {
            withAnimation(Animation.easeInOut) {
                isMenu.toggle()
            }
        }
    }
}

struct MenuToCrossicon_Previews: PreviewProvider {
    static var previews: some View {
        MenuToCrossicon()
    }
}
