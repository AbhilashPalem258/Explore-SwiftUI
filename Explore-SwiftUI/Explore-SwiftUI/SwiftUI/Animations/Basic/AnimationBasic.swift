//
//  AnimationBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/12/22.
//

import SwiftUI

/*
 Source:
 animationImplement1 - https://www.youtube.com/watch?v=0H4G3lGnJE0&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=27
 
 Definition:
 
 Notes:
 */

struct AnimationBasic: View {
    
    @State private var isAnimated = false
    let timing = 10.0
    
    var animationImplement1: some View {
        VStack {
            Button {
//                withAnimation(.default) {
                withAnimation(
                    Animation
                        .easeInOut(duration: 5)
//                        .delay(2)
//                        .repeatCount(5, autoreverses: true)
//                        .repeatCount(5, autoreverses: false)
//                        .repeatForever()
                        .repeatForever(autoreverses: false)
                ) {
                    self.isAnimated.toggle()
                }
            } label: {
                Text("PRESS")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .cornerRadius(10.0)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? .red : .green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300
                )
                .rotationEffect( Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300: 0)
            
            Spacer()
        }
    }
    
    var animationImplement2: some View {
        VStack {
            Button {
                isAnimated.toggle()
            } label: {
                Text("PRESS")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
                    .cornerRadius(10)
            }
            Spacer()
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 350 : 0, height: 100)
            // Constant speed throught the animation
                .animation(.linear, value: isAnimated)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 350 : 0, height: 100)
            // Slow start and increase speed gradually
                .animation(.easeIn, value: isAnimated)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 350 : 0, height: 100)
            // Slow Fast Slow
                .animation(.easeInOut, value: isAnimated)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 350 : 0, height: 100)
            // Fast - Slow
                .animation(.easeOut, value: isAnimated)
            
            Spacer()
        }
    }
    
    var body: some View {
        animationImplement2
    }
}

struct AnimationBasic_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBasic()
    }
}
