//
//  DynamicTabIndicatorsKav.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/02/23.
//

import SwiftUI

/*
 Source:
 https://www.youtube.com/watch?v=z0VWKhpZ5vY
 
 Definition:
 
 Notes:
 */

struct TabItem: Identifiable, Hashable {
    let id: Int
    let title: String
}

fileprivate var tabs_ : [TabItem] = [
    TabItem(id: 0, title: "Light"),
    TabItem(id: 1, title: "Window"),
    TabItem(id: 2, title: "Arch"),
    TabItem(id: 3, title: "Flowers")
]

struct DynamicTabIndicatorsKav: View {
    
    @State private var selectedTab = tabs_[0]
    @State private var tabs: [TabItem] = tabs_
    @State private var contentOffset: CGFloat = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs) { tab in
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    Image(tab.title)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .clipped()
                .ignoresSafeArea()
                .offsetX { rect in
                    if selectedTab == tab {
                        contentOffset = rect.minX - (CGFloat(index(of: selectedTab)) * rect.width)
                    }
                }
                .tag(tab)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(
            TabsView
        , alignment: .top)
        .overlay {
            Text(contentOffset.description)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
        }
    }
    
    private func index(of tab: TabItem) -> Int {
        tabs.firstIndex(of: tab) ?? 0
    }
    
    private var TabsView: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                Text(tab.title)
                    .fontWeight(.semibold)
                if tabs.last != tab {
                    Spacer(minLength: 0)
                }
            }
        }
        .foregroundColor(.white)
        .padding([.top, .horizontal], 15)
        .overlay(
            Rectangle()
                .fill(.white)
                .frame(height: 4)
                .offset(y: 10)
        ,alignment: .bottomLeading)
    }
}

struct DynamicTabIndicatorsKav_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTabIndicatorsKav()
    }
}

fileprivate extension View {
    func offsetX(completion: @escaping (CGRect) -> Void) -> some View {
        self.overlay {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                
                Color.clear
                    .preference(key: OffsetKey.self, value: rect)
                    .onPreferenceChange(OffsetKey.self, perform: completion).self
            }
        }
    }
}

fileprivate struct OffsetKey: PreferenceKey {
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
    
    static var defaultValue: CGRect = .zero
}
