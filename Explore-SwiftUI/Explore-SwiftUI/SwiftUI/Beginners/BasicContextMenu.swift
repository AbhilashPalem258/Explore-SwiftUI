//
//  BasicContextMenu.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 14/12/22.
//

import SwiftUI

struct BasicContextMenu: View {
    var body: some View {
        ZStack {
            Color.secondary
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "house.fill")
                    .font(.title)
                Text("SwiftUI Bootcamp")
                    .font(.headline)
                Text("How to use Bootcamp")
                    .font(.subheadline)
            }
            .padding()
            .foregroundColor(.white)
            .background(.black)
            .cornerRadius(20)
            .contextMenu {
                Label {
                    Text("Menu Item #2")
                } icon: {
                    Image(systemName: "flame.fill")
                }
                
                Label("DevTechie", systemImage: "heart.fill")
                    .labelStyle(.titleAndIcon)
                    .foregroundColor(.red)
                    .font(.largeTitle)
                
                Label("Menu Item #2", systemImage: "menucard")
                Label("Menu Item #3", systemImage: "menucard")
            }
            
        }
    }
}

struct BasicContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        BasicContextMenu()
    }
}
