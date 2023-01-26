//
//  DragGestureBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/07/22.
//

import Foundation
import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Max width: \(UIScreen.main.bounds.width/2)")
            Text("Current Amount: \(abs(offset.width))")

            Rectangle()
                .frame(width: 200, height: 300)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                self.offset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                self.offset = .zero
                            }
                        }
                )
        }
    }
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}
