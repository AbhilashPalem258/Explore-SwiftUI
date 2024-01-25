//
//  ScrollTransitionExample.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 31/12/23.
//

import SwiftUI

/*
 link:
 - https://www.youtube.com/watch?v=8YHbhSmiKwU&t=605s
 Notes:
 - ContainerRelativeFrame Horizontal and contentMargins Horizontal can't be used at same time. contentMargins Horizontal doesn't work.
 */

@available(iOS 17.0, *)
struct ScrollTransitionExample: View {
    
    @State private var colors: [Color] = [.red, .blue, .green, .teal, .cyan, .orange]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(0..<colors.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colors[index])
                            .frame(height: 200)
//                            .containerRelativeFrame(.horizontal)
                            .overlay {
                                Text(index.description)
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.white)
                            }
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                            }
                    }
                }
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .navigationTitle("Scroll Transition")
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ScrollTransitionExample()
}
