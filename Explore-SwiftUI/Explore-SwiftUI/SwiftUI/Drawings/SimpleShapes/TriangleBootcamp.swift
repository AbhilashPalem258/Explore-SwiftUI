//
//  TriangleBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/07/22.
//

import Foundation
import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct TriangleBootcamp: View {
    var body: some View {
        Triangle()
//            .fill(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
            .foregroundColor(.blue)
            .frame(width: 300, height: 300)
        
//        Image("Damini")
//            .resizable()
//            .scaledToFill()
//            .frame(width: 300, height: 300)
//            .clipShape(Triangle().rotation(Angle(degrees: 180)))
    }
}

struct TriangleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TriangleBootcamp()
    }
}
