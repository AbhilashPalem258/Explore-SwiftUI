//
//  GeometryPreferenceKeyBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 14/07/22.
//

import Foundation
import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var updatedGeo: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Abhilash")
                .fontWeight(.semibold)
                .frame(width: updatedGeo.width, height: updatedGeo.height)
                .background(.blue)
                .foregroundColor(.white)
                .padding(.vertical)
            
            Spacer()
            
            HStack {
                Rectangle()
                GeometryReader { proxy in
                    Rectangle()
                        .overlay(
                            Text("\(proxy.size.width)")
                                .updateGeo(proxy.size)
                                .foregroundColor(.white)
                                
                        )
                }
                Rectangle()
            }
            .frame(height: 55)
            .padding()
        }
        .onPreferenceChange(GeometryPreferenceKey.self) { newSize in
            self.updatedGeo = newSize
        }
    }
}

fileprivate struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}

fileprivate extension View {
    func updateGeo(_ newValue: CGSize) -> some View {
        preference(key: GeometryPreferenceKey.self, value: newValue)
    }
}

fileprivate struct GeometryPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
