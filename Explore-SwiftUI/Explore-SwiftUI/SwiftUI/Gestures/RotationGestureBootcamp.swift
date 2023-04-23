//
//  RotationGestureBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/07/22.
//

import Foundation
import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    //Swiftful Thinking
    var example1: some View {
        Text("Rotation Gesture")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(40)
            .background(.blue)
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        self.angle = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            self.angle = Angle(degrees: 0)
                        }
                    }
            )
    }
    
    @State private var currentRotation =  Angle(degrees: 0)
    @GestureState private var twistAngle = Angle(degrees: 0)
    
    var example2: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.red)
            .frame(width: 200, height: 100)
            .rotationEffect(currentRotation + twistAngle)
            .gesture(
                RotationGesture()
                    .updating($twistAngle) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        currentRotation += value
                    }
            )
    }
    
    @State private var currentMagnification: CGFloat = 1.0
    @GestureState private var pinchMagnification: CGFloat = 1.0
    
    var RotationMagnificationSimultaneous: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
            .frame(width: 300, height: 200)
            .scaleEffect(currentMagnification * pinchMagnification)
            .rotationEffect(currentRotation + twistAngle)
            .gesture(
                MagnificationGesture()
                    .updating($pinchMagnification) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        currentMagnification *= value
                    }
                    .simultaneously(with:
                        RotationGesture()
                            .updating($twistAngle) { value, state, _ in
                                state = value
                            }
                            .onEnded { value in
                                currentRotation += value
                            }
                    )
            )
    }
    
    var body: some View {
        RotationMagnificationSimultaneous
    }
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}
