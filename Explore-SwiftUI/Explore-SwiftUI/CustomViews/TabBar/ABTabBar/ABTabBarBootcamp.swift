//
//  ABTabBarBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/07/22.
//

import Foundation
import SwiftUI

struct ABTabBarBootcamp: View {
    
    @State var selection: ABTabBarItem = .home
    
    var body: some View {
        ABTabBarContainerView(selection: $selection) {
            Color.red
                .abTabItem(.home, selection: $selection)
            
            Color.blue
                .abTabItem(.favorites, selection: $selection)
            
            Color.green
                .abTabItem(.profile, selection: $selection)
            
            Color.purple
                .abTabItem(.settings, selection: $selection)
        }
    }
}

struct ABTabBarBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ABTabBarBootcamp()
    }
}
