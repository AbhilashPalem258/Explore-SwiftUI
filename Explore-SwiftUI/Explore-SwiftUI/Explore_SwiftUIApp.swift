//
//  Explore_SwiftUIApp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import SwiftUI

@main
struct Explore_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                PhaseAnimationsBootcamp()
                    .preferredColorScheme(.light)
            } else {
                SampleTabBar()
            }
        }
    }
}
