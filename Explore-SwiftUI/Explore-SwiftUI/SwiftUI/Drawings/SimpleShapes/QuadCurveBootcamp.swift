//
//  QuadCurveBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/07/22.
//

import Foundation
import SwiftUI

struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.midX/2, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.midX + rect.midX/2, y: rect.maxY))
//            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        }
    }
}

struct QuardCurveBootcamp: View {
    var body: some View {
        VStack {
            ForEach(0..<5) { index in
                Wave()
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
                    .frame(width: 300, height: 100)
            }
        }
    }
}

struct QuardCurveBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        QuardCurveBootcamp()
    }
}
