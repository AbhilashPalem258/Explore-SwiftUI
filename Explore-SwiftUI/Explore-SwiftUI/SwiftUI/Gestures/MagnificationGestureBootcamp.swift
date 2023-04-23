//
//  MagnificationGesture.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 09/07/22.
//

import Foundation
import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentAmount: CGFloat = 0.0
    @State var lastAmount: CGFloat = 0.0
    
    
    var example1: some View {
        Text("Shiny World!")
            .font(.title)
            .padding()
            .background(.red)
            .cornerRadius(10)
            .scaleEffect(1 + currentAmount + lastAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        print("current value: \(value)")
                        currentAmount = value - 1
                    }
                    .onEnded { value in
                        lastAmount += currentAmount
                    }
            )
    }
    
    
    @State private var currentMagnification: CGFloat = 1.0
    @GestureState private var pinchMagnification: CGFloat = 1.0

    var example2: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 100)
            .scaleEffect(currentMagnification * pinchMagnification)
            .gesture(
                MagnificationGesture()
                    .updating($pinchMagnification) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        currentMagnification *= value
                    }
            )
    }
    
    var body: some View {
        example2
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}

struct InstaFeedPostMaginficationDemo: View {
    
    @State var currentAmount: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Shiny")
                    .font(.headline)
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            ZStack {
                Color.black
                Image("Damini")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1 + currentAmount)
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                currentAmount = value - 1
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    currentAmount = 0
                                }
                            }
                    )
            }
            .frame(height: 300)
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            Text("This is the caption")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

struct InstaFeedPostMaginficationDemo_Previews: PreviewProvider {
    static var previews: some View {
        InstaFeedPostMaginficationDemo()
    }
}
