//
//  ScrollViewReader.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 11/07/22.
//

import Foundation
import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textfieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            
            TextField("Enter #", text: $textfieldText)
                .frame(height: 55)
                .padding(.horizontal)
                .border(Color.gray)
                .keyboardType(.numberPad)
                .padding(.horizontal)
            
            Button("Scroll Now") {
                if let index = Int(textfieldText) {
                    self.scrollToIndex = index
                }
            }

            ScrollView {
                ScrollViewReader { proxy in
                    
//                    Button("Scroll To #30") {
//                        withAnimation(.spring()) {
//                            proxy.scrollTo(30, anchor: .bottom)
//                        }
//                    }
                    
                    ForEach(0..<50) { index in
                        Text("Row: \(index)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
