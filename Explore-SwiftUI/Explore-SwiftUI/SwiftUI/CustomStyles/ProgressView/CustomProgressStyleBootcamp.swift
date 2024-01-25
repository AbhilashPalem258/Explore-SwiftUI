//
//  CustomProgressStyleBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 24/01/23.
//

import SwiftUI

struct CustomProgressStyleBootcamp: View {
    
    @State private var progress: CGFloat = 0.5
    
    var body: some View {
        VStack{
            ProgressView(value: progress) {
                Label("Battery", systemImage: "battery.50")
            } currentValueLabel: {
                Text("Current Charge")
            }
            .progressViewStyle(BatteryProgressStyle(width: 250, height: 50))
            
            Button("Charge") {
                progress = 0.0
                withAnimation(Animation.linear(duration: 2.0)) {
                    progress = 1.0
                }
            }
            .tint(.green)
            .buttonStyle(.borderedProminent)
        }
    }
}

fileprivate struct BatteryProgressStyle: ProgressViewStyle {
    let width: CGFloat
    let height: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.green, lineWidth: 2)
                .frame(width: width, height: height)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(LinearGradient(colors: [.black, .green], startPoint: .leading, endPoint: .trailing))
                        .frame(width: width * CGFloat(configuration.fractionCompleted!))
                }
            configuration.currentValueLabel
        }
    }
}

struct CustomProgressStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressStyleBootcamp()
    }
}
