//
//  CustomTabBar.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/07/22.
//

import Foundation
import SwiftUI

struct ABTabBar: View {
    
    enum TabType {
        case classic
        case sliding
    }

    @Binding var selection: ABTabBarItem
    let tabs: [ABTabBarItem]
    let type: TabType
    @State var localSelection: ABTabBarItem
    
    @Namespace var namespace
    
    var body: some View {
        tabBar
    }
    
    @ViewBuilder private var tabBar: some View {
        switch type {
        case .classic:
             classicTabBar
                .padding(6)
                .background(Color.white.edgesIgnoringSafeArea(.bottom))
        case .sliding:
             slidingTabBar
                .onChange(of: selection) { newValue in
                    withAnimation(.easeInOut) {
                        localSelection = newValue
                    }
                }
        }
    }
}

extension ABTabBar {
    func classictabBarItem(_ item: ABTabBarItem) -> some View {
        VStack {
            Text(item.name)
                .font(.subheadline)
            Image(systemName: item.icon)
                .font(.system(size: 12, weight: .bold, design: .rounded))
        }
        .foregroundColor(selection == item ? item.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == item ? item.color.opacity(0.2)  : .clear)
        .cornerRadius(10)
    }
    
    var classicTabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tabItem in
                classictabBarItem(tabItem)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selection = tabItem
                        }
                    }
            }
        }
    }
}

extension ABTabBar {
    var slidingTabBar: some View {
        HStack {
            ForEach(tabs, id:\.self) { tabItem in
                slidingtabBarItem(tabItem)
                    .onTapGesture {
                        self.selection = tabItem
                    }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    func slidingtabBarItem(_ item: ABTabBarItem) -> some View {
        VStack {
            Image(systemName: item.icon)
                .font(.headline)
            Text(item.name)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == item ? item.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == item {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.color.opacity(0.2))
                        .matchedGeometryEffect(id: "ABTabItemId", in: namespace)
                }
            }
        )
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [ABTabBarItem] = [
            .home,
            .favorites,
            .profile,
            .settings
        ]
        
        VStack {
            Spacer()
            ABTabBar(selection: .constant(.home), tabs: tabs, type: .classic, localSelection: .home)
        }
    }
}
