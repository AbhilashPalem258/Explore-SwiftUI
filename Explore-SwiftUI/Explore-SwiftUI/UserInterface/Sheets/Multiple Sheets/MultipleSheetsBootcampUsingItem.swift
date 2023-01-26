//
//  MultipleSheetsBootcampUsingItem.swift
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

fileprivate struct RandomModel: Identifiable {
    let id: UUID = UUID()
    let name: String
}

struct MultipleSheetsBootcampUsingItem: View {
    
    @State private var selectedModel: RandomModel? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Sheet 1")
                .modifier(BtnRegular())
                .onTapGesture {
                    selectedModel = RandomModel(name: "Sheet 1")
                }
            
            Text("Sheet 2")
                .modifier(BtnRegular())
                .onTapGesture {
                    selectedModel = RandomModel(name: "Sheet 2")
                }
        }
        .sheet(item: $selectedModel) { item in
            RandomScreen(model: item)
        }
    }
}

fileprivate struct RandomScreen: View {
    let model: RandomModel
    var body: some View {
        Text(model.name)
            .modifier(BtnRegular())
    }
}

struct MultipleSheetsBootcampUsingItem_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcampUsingItem()
    }
}
