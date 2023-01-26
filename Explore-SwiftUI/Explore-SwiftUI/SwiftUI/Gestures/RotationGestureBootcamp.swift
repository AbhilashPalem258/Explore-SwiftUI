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
    
    var body: some View {
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
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}
