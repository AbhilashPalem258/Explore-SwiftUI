//
//  ThreeDotRotationLoading.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/07/22.
//

import Foundation
import SwiftUI

struct ThreeDotRotationLoading: View {
    
    @State var isAnimating = false
    
    var body: some View {
        HStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 10)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 10)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 10)
        }
        .rotationEffect(isAnimating ? Angle(degrees: 180) : Angle(degrees: 0))
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: false)) {
                isAnimating.toggle()
            }
        }
    }
}

struct ThreeDotRotationLoading_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotRotationLoading()
    }
}
