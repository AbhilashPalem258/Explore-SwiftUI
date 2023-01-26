//
//  ToggleStyleBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 24/01/23.
//

import SwiftUI

struct ToggleStyleBootcamp: View {
    
    @State private var firstCheckboxState: Bool = false
    @State private var secondCheckboxState: Bool = false
    
    var body: some View {
        VStack{
            GroupBox("Checkbox Toggle") {
                Toggle(isOn: $firstCheckboxState) {
                    Text("Checkbox 1")
                }
                .toggleStyle(CheckboxToggleStyle())
                
                Toggle(isOn: $secondCheckboxState) {
                    Text("Checkbox 2")
                }
                .toggleStyle(CheckboxToggleStyle(isReversed: true))
            }
            
            GroupBox("Colored Switch") {
                Toggle(isOn: $firstCheckboxState) {
                    Text("Toggle Me")
                }
                .toggleStyle(ColoredSwitchToggleStyle(foregroundColor: .red))
                
                Toggle(isOn: $secondCheckboxState) {
                    Text("Toggle Me2")
                }
                .toggleStyle(ColoredSwitchToggleStyle(foregroundColor: .green))
            }
            
            Spacer()
        }
    }
}

fileprivate struct CheckboxToggleStyle: ToggleStyle {
    var isReversed: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if !isReversed {
                configuration.label
            }
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .font(.headline.bold())
                    .foregroundColor(.black)
            }
            .padding(5)
            if isReversed {
                configuration.label
            }
        }
    }
}

fileprivate struct ColoredSwitchToggleStyle: ToggleStyle {
    let foregroundColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 10) {
            configuration.label
            RoundedRectangle(cornerRadius: 5)
                .stroke(foregroundColor, lineWidth: 2)
                .frame(width: 50, height: 20)
                .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(foregroundColor)
                        .frame(width: 25, height: 20)
                }
                .onTapGesture {
                    withAnimation(Animation.linear(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct ToggleStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToggleStyleBootcamp()
    }
}
