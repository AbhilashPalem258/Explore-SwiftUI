//
//  MultipleSheetsUsingSheetModifiersBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 11/07/22.
//

import Foundation
import SwiftUI

fileprivate struct BtnRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            
    }
}

struct MultipleSheetsUsingSheetsModifierBootcamp: View {
    
    @State private var showSheet1 = false
    @State private var showSheet2 = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Sheet 1")
                .modifier(BtnRegular())
                .onTapGesture {
                    showSheet1.toggle()
                }
                .sheet(isPresented: $showSheet1) {
                    RandomScreen(model: RandomModel(name: "Sheet 1"))
                }
            
            Text("Sheet 2")
                .modifier(BtnRegular())
                .onTapGesture {
                    showSheet2.toggle()
                }
                .sheet(isPresented: $showSheet2) {
                    RandomScreen(model: RandomModel(name: "Sheet 2"))
                }
        }
    }
}


fileprivate struct RandomModel: Identifiable {
    let id: UUID = UUID()
    let name: String
}

fileprivate struct RandomScreen: View {
    
    let model: RandomModel
    
    var body: some View {
        Text(model.name)
            .modifier(BtnRegular())
    }
}

struct MultipleSheetsUsingSheetsModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsUsingSheetsModifierBootcamp()
    }
}
