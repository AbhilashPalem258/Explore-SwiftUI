//
//  ShapeBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 09/12/22.
//

import SwiftUI

struct ShapeBootcamp: View {
    var body: some View {
//        Circle()
        Ellipse()
//        Rectangle()
//        RoundedRectangle(cornerRadius: 50)
//            .fill()
//            .fill(Color.brown)
//            .stroke()
//            .stroke(Color.red)
//            .stroke(Color.red, style: StrokeStyle(lineWidth: 10))
//            .stroke(style: StrokeStyle(lineWidth: 10))
//            .stroke(Color.orange, style: StrokeStyle(lineWidth: 30, lineCap: .butt, dash: [30]))
//            .stroke(Color.orange, style: StrokeStyle(lineWidth: 30, lineCap: .round, dash: [30]))
            .trim(from: 0.25, to: 1.0)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 30))
            .frame(width: 200, height: 100)
//            .background(.red)
    }
}

struct ShapeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ShapeBootcamp()
    }
}
