//
//  AnyTransitionBootcamp_SwiftfulThinking.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

struct StyledButtonTypeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.headline)())
            .foregroundColor(.white)
            .frame(height: 65)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(10)
            .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 10)
            .padding(.horizontal, 16)
    }
}

extension View {
    func StyledButtonType() -> some View {
        modifier(StyledButtonTypeModifier())
    }
}

struct RotationOffsetViewModifier: ViewModifier {
    
    let rotation: Double
    init(rotation: Int) {
        self.rotation = Double(rotation)
    }
    
    var isIdenity: Bool {
        return rotation == 0
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isIdenity ? 0 : rotation))
            .offset(
                x: isIdenity ? 0 : UIScreen.main.bounds.width,
                y:  isIdenity ? 0 : UIScreen.main.bounds.height)

    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        modifier(
            active: RotationOffsetViewModifier(rotation: 180),
            identity: RotationOffsetViewModifier(rotation: 0)
        )
    }
    
    static func rotation(amount: Int) -> AnyTransition {
        modifier(
            active: RotationOffsetViewModifier(rotation: amount),
            identity: RotationOffsetViewModifier(rotation: 0)
        )
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(
            insertion: .move(edge: .top),
            removal: .rotating
        )
    }
}

struct AnyTransitionBootcamp: View {
    
    @State private var showRectView = false
    
    var body: some View {
        VStack {
            Spacer()
            if !showRectView {
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [Color(uiColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), Color(uiColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
//                    .modifier(RotationOffsetViewModifier(rotation: 0))
            }
            Spacer()
            Text("Hello World")
                .StyledButtonType()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        showRectView.toggle()
                    }
                }
        }
        .background(Color.white)
    }
}

struct AnyTransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionBootcamp()
    }
}
