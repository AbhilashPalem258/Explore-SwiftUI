//
//  CarouselAnimeBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

struct CarouselAnimeBootcamp: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<10) { _ in
                    GeometryReader { geoProxy in
                        RoundedRectangle(cornerRadius: 25)
                            .rotation3DEffect(Angle(degrees: getPercentage(geoProxy: geoProxy) *  40), axis: (0.0, 1.0, 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding(16)
                }
            }
        }
    }
    
    func getPercentage(geoProxy: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geoProxy.frame(in: .global).midX
        return Double(1 - currentX/maxDistance)
    }
}

struct CarouselAnimeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CarouselAnimeBootcamp()
    }
}
