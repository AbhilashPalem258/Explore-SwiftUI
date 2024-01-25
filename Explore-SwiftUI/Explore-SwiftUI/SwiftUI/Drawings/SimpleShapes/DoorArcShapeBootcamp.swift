//
//  DoorArcShapeBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/07/22.
//

import Foundation
import SwiftUI

struct DoorArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        }
    }
}

struct DoorArcShapeBootcamp: View {
    var body: some View {
        DoorArc()
            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
            .frame(width: 200, height: 300)
            .background(.red)
    }
}

struct DoorArcShapeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoorArcShapeBootcamp()
    }
}
