//
//  SwiftUITabBar.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/07/22.
//

import Foundation
import SwiftUI

struct SwiftUITabBarBootcamp: View {
    
    @State private var selectedTab: Int = 3
    
    var  body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
                .badge(1)
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Favourites")
                .badge(2)
                .tag(1)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }
            
            Text("Profile")
                .badge(3)
                .tag(2)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            Text("Settings")
                .badge(4)
                .tag(3)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct SwiftUITabBarBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITabBarBootcamp()
    }
}
