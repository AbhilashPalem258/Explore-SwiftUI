//
//  ArcBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/07/22.
//

import Foundation
import SwiftUI

struct CircleFilled: Shape {
    
    let start: Angle
    let end: Angle
    let clockwise: Bool
    
    init(start: Double, end: Double, clockwise: Bool) {
        self.start = Angle(degrees: start)
        self.end = Angle(degrees: end)
        self.clockwise = clockwise
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: start, endAngle: end, clockwise: !clockwise)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        }
    }
}

struct ArcBootcamp: View {
    var body: some View {
        CircleFilled(start: -20, end: 20, clockwise: false)
//            .fill(.blue)
            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
            .frame(width: 200, height: 200)
    }
}

struct ArcBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArcBootcamp()
    }
}
