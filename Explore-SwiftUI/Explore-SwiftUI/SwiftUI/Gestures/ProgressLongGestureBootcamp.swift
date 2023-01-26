//
//  ProgressLongGestureBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

fileprivate struct ActionButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.bold))
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal, 20)
            .background(Color.black)
            .cornerRadius(10)
    }
}

struct ProgressLongGestureBootcamp: View {
    
    @State private var isComplete = false
    @State private var isSuccess = false
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Rectangle()
                    .fill( !isSuccess ? .blue : .green)
                    .frame(height: 65)
                    .frame(maxWidth: !isComplete ? 0 : .infinity)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray)
                
                HStack(spacing: 16) {
                    Text("Click Me!")
                        .modifier(ActionButtonStyle())
//                        .onLongPressGesture(minimumDuration: <#T##Double#>, maximumDistance: <#T##CGFloat#>, perform: <#T##() -> Void#>, onPressingChanged: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
                        .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                            withAnimation(.easeInOut) {
                                isSuccess = true
                            }
                        } onPressingChanged: { isPressing in
                            if isPressing {
                                print("isPressing: \(isPressing)")
                                withAnimation(.easeInOut(duration: 1)) {
                                    isComplete = true
                                }
                            } else  {
                                print("isPressing: NOT \(isPressing)")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSuccess {
                                        withAnimation(.easeInOut) {
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                        }
                    
                    Text("Reset")
                        .modifier(ActionButtonStyle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isSuccess = false
                                isComplete = false
                            }
                        }
                        
                }
            }
        }
    }
}

struct ProgressLongGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLongGestureBootcamp()
    }
}
