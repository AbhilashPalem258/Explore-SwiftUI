//
//  ABTabBarItemPreferenceKey.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/07/22.
//

import Foundation
import SwiftUI

struct ABTabBarItemPreferenceKey: PreferenceKey {
    static var defaultValue: [ABTabBarItem] = []
    
    static func reduce(value: inout [ABTabBarItem], nextValue: () -> [ABTabBarItem]) {
        value += nextValue()
    }
}

struct ABTabBarItemViewModifier: ViewModifier {
    
    let tabItem: ABTabBarItem
    @Binding var selection: ABTabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tabItem ? 1.0 : 0.0)
            .preference(key: ABTabBarItemPreferenceKey.self, value: [tabItem])
    }
}

extension View {
    func abTabItem(_ item: ABTabBarItem, selection: Binding<ABTabBarItem>) -> some View {
        modifier(ABTabBarItemViewModifier(tabItem: item, selection: selection))
    }
}
