//
//  ColorPickerBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 20/12/22.
//

import SwiftUI

struct ColorPickerBasic: View {
    
    @State private var bgColor = Color.green
    
    var colorPicker1: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            
            ColorPicker("Select Color", selection: $bgColor, supportsOpacity: true)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .cornerRadius(10)
                .shadow(color: .black, radius: 10.0, x: 0.0, y: 10.0)
                .padding()
        }
    }
    
    var colorPicker2: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            
            ColorPicker(selection: $bgColor, supportsOpacity: true) {
                Circle()
                    .fill(.brown)
                    .frame(width: 100, height: 100)
            }
        }
    }
    
    var body: some View {
        colorPicker1
    }
}

struct ColorPickerBasic_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerBasic()
    }
}
