//
//  ABTabBarItem.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/07/22.
//

import Foundation
import SwiftUI

enum ABTabBarItem: Hashable {
    case home, favorites, profile, settings
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .favorites:
            return "star"
        case .profile:
            return "person"
        case .settings:
            return "gear"
        }
    }
    
    var name: String {
        switch self {
        case .home:
            return "Home"
        case .favorites:
            return "Favourites"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .red
        case .favorites:
            return .blue
        case .profile:
            return .green
        case .settings:
            return .purple
        }
    }
}
