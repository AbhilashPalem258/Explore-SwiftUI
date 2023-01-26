//
//  BasicTransition.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 12/12/22.
//

import SwiftUI

struct BasicTransition: View {
    
    @State private var showBottomView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Button {
                    withAnimation(Animation.easeInOut) {
                        self.showBottomView.toggle()
                    }
                } label: {
                    Text("Animate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 10)
                        .background(.black)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            
            if showBottomView {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(AnyTransition.slide)
//                    .transition(AnyTransition.opacity)
//                    .transition(AnyTransition.scale)
//                    .transition(AnyTransition.move(edge: .bottom))
//                    .transition(AnyTransition.move(edge: .leading))
                    .transition(
                        AnyTransition.asymmetric(
                            insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge: .bottom)
                        )
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct BasicTransition_Previews: PreviewProvider {
    static var previews: some View {
        BasicTransition()
    }
}
