//
//  LongPressGesture1.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/06/23.
//

import SwiftUI

struct LongPressGesture1: View {
    
    @GestureState private var isPressing = false
    @State private var numberOfTaps = 0
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 1.0)
//        let longPressGesture = TapGesture(count: 1)
        
            //Update transient UI state
            .updating($isPressing) { value, state, transaction in
                print("value: \(value), state: \(state), transaction: \(transaction)")
                state = value
            }
        
            //Update permanent state during a gesture
            .onChanged { value in
                numberOfTaps += 1
            }
        
            //Update permanent state when a gesture ends
            .onEnded { value in
                numberOfTaps += 1
            }
        
        return VStack {
            Circle()
                .fill(isPressing ? .red : .green)
                .frame(width: 200)
                .gesture(longPressGesture)
            
            Text("Number of Taps: \(numberOfTaps)")
                .font(.title2)
                .bold()
        }
    }
}

struct LongPressGesture1_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture1()
    }
}
