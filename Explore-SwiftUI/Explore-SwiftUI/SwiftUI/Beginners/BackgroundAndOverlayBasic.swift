//
//  BackgroundAndOverlayBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/12/22.
//

import SwiftUI

struct BackgroundAndOverlayBasic: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            Image(systemName: "heart.fill")
                .font(.system(size: 40.0, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 100, height: 100)
                        .shadow(color: Color.blue, radius: 10, x: 0.0, y: 10.0)
                        .overlay(
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                                .shadow(color: Color.blue, radius: 10, x: 0.0, y: 10.0)
                                .overlay(
                                    Text("15")
                                        .foregroundColor(.white)
                                )
                            , alignment: .bottomTrailing
                        )
                )
        }
    }
}

struct BackgroundAndOverlayBasic_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAndOverlayBasic()
    }
}
