//
//  BadgeBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 05/01/23.
//

import SwiftUI

struct BadgeBasic: View {
    
    var tabViewExample: some View {
        TabView {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .badge(10)
            
            Color.green
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }
                .badge("New")
            
            Color.blue
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .badge("12")
        }
    }
    
    var listViewExample: some View {
        List {
            Section("Fruits") {
                Text("Apple")
                    .badge(12)
                Text("Banana")
                    .badge("New")
                Text("Pomegranate")
                    .badge("32")
                Text("Orange")
                Text("Kiwi")
            }
        }
    }
    
    var body: some View {
        tabViewExample
    }
}

struct BadgeBasic_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBasic()
    }
}
