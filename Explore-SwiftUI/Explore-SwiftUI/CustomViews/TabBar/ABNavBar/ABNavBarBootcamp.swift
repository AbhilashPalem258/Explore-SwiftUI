//
//  ABNavBarBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/07/22.
//

import Foundation
import SwiftUI

fileprivate struct ActionButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.bold))
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal, 20)
            .background(Color.blue)
            .cornerRadius(10)
    }
}
struct ABNavBarBootcamp: View {
    var body: some View {
        defaultNavBar
    }
}
extension ABNavBarBootcamp {
    var defaultNavBar: some View {
        NavigationView {
            ZStack {
                Color.purple.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Primary Screen")
                    
                    NavigationLink {
                        ZStack {
                            Color.brown.edgesIgnoringSafeArea(.all)
                            Text("Secondary screen")
                                .modifier(ActionButtonStyle())
                                .navigationTitle("Secondary Screen")
                                .navigationBarBackButtonHidden(true)
                                .navigationBarTitleDisplayMode(.automatic)
                        }
                    } label: {
                        Text("Navigate").modifier(ActionButtonStyle())
                    }

                }
            }
        }
    }
}

struct ABNavBarBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ABNavBarBootcamp()
    }
}
