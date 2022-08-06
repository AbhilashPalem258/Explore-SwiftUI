//
//  AnimatableDataBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 14/07/22.
//

import Foundation
import SwiftUI

//MARK: - Animation Introduction

fileprivate struct RectRadiusAnimatable: View {
    
    @State var animate = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: animate ? 150.0 : 0.0)
                .fill(LinearGradient(colors: [.red, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 300, height: 300)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever()) {
                        animate.toggle()
                    }
                }
    }
}

struct RectRadiusAnimatable_Previews: PreviewProvider {
    static var previews: some View {
        RectangleWithSingleCornerRadiusAnimation()
    }
}


//MARK: - RectangleWithSingleCornerRadiusAnimation

struct RectangleWithSingleCornerRadiusAnimation: View {
    
    @State var animate = false
    
    var body: some View {
        RectangleWithSingleCornerRadius(cornerRadius: animate ? 60 : 0)
            .fill(.brown)
            .frame(width: 300, height: 300)
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever()) {
                    animate.toggle()
                }
            }
    }
}

fileprivate struct RectangleWithSingleCornerRadius: Shape {
    
    var cornerRadius: CGFloat
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

fileprivate struct RectangleWithSingleCornerRadiusAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RectangleWithSingleCornerRadiusAnimation()
    }
}

//MARK: - Pacman animation
struct PacmanShape: Shape {
    
    var offset: Double
    var animatableData: Double {
        get {offset}
        set {offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2, startAngle: Angle(degrees: offset), endAngle: Angle(degrees: 360 - offset), clockwise: false)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        }
    }
}

struct PacmanView: View {
    
    @State var animate = false
    
    var body: some View {
        PacmanShape(offset: animate ? 20 : 0)
            .fill(.brown)
//            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round,dash: [5]))
            .frame(width: 100, height: 100)
            .onAppear {
                withAnimation(.linear.repeatForever()) {
                    animate.toggle()
                }
            }
    }
}

struct PacmanView_Previews: PreviewProvider {
    static var previews: some View {
        PacmanView()
    }
}
