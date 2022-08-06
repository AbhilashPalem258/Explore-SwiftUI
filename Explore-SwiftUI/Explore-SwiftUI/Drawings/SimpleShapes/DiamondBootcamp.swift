//
//  DiamondBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/07/22.
//

import Foundation
import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct DiamondBootcamp: View {
    var body: some View {
        Diamond()
            .fill(LinearGradient(colors: [.red, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 300, height: 300)
    }
}

struct DiamondBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DiamondBootcamp()
    }
}
