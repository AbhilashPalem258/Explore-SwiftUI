//
//  ABTabBarItemContainerView.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/07/22.
//

import Foundation
import SwiftUI

struct ABTabBarContainerView<Content: View>: View {
    
    @Binding var selection: ABTabBarItem
    let content: Content
    
    @State var tabs: [ABTabBarItem] = []

    
    init(selection: Binding<ABTabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .edgesIgnoringSafeArea(.bottom)
            ABTabBar(selection: $selection, tabs: tabs, type: ABTabBar.TabType.sliding, localSelection: selection)
        }
        .onPreferenceChange(ABTabBarItemPreferenceKey.self) { items in
            self.tabs = items
        }
    }
}

struct ABTabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ABTabBarContainerView(selection: .constant(.home)) {
            Color.red
                .abTabItem(.home, selection: .constant(.home))
            
            Color.blue
                .abTabItem(.favorites, selection: .constant(.home))
        }
    }
}
