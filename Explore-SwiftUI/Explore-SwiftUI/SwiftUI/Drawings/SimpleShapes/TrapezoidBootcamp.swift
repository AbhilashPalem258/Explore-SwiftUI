//
//  TrapezoidBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/07/22.
//

import Foundation
import SwiftUI

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
}

struct TrapezoidBootcamp: View {
    var body: some View {
        Trapezoid()
            .frame(width: 300, height: 200)
    }
}

struct TrapezoidBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TrapezoidBootcamp()
    }
}
