//
//  SFSymbolAnimations.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 02/01/24.
//

import SwiftUI

struct SFSymbolAnimations: View {
    var body: some View {
        TabView {
            DiscretBehaviour()
                .tabItem {
                    Label {
                        Text("Discret")
                    } icon: {
                        Image(systemName: "plus")
                    }

                }
        }
    }
}

fileprivate struct DiscretBehaviour: View {
    var body: some View {
        NavigationStack {
            Form {
                
            }
        }
    }
}

fileprivate struct IndefiniteBehaviour: View {
    var body: some View {
        NavigationStack {
            
        }
    }
}

fileprivate struct ContentTransitionBehaviour: View {
    var body: some View {
        NavigationStack {
            
        }
    }
}

#Preview {
    SFSymbolAnimations()
}
