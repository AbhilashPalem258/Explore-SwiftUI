//
//  RatingViewMaskBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 12/07/22.
//

import Foundation
import SwiftUI

struct RatingViewMaskBootcamp: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        starView
            .overlay(
                overlayView.mask(starView)
            )
    }
    
    private var starView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { proxy in
            HStack {
                Rectangle()
                    .foregroundColor(.yellow)
//                    .fill(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
                    .frame(width: (CGFloat(rating) / 5) * proxy.size.width)
                Spacer()
            }
        }
        .allowsHitTesting(false)
    }
}

struct RatingViewMaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RatingViewMaskBootcamp()
    }
}
