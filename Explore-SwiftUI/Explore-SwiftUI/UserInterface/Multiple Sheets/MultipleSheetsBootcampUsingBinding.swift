//
//  MultipleSheetsBootcamp.swift
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
    let id: UUID
    let title: String
}

/*
 Solutions:
 1. use Binding
 2. multiple sheets
 3. $item
 */

struct MultipleSheetsBootcampUsingBinding: View {
    
    @State fileprivate var selectedModel = RandomModel(id: UUID(), title: "Starting title")
    @State var showSheet = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Sheet 1")
                .modifier(BtnRegular())
                .onTapGesture {
                    selectedModel = RandomModel(id: UUID(), title: "Nav screen")
                    showSheet.toggle()
                }
            
            Text("Sheet 2")
                .modifier(BtnRegular())
                .onTapGesture {
                    selectedModel = RandomModel(id: UUID(), title: "Home screen")
                    showSheet.toggle()
                }
        }
//        .sheet(isPresented: <#T##Binding<Bool>#>, onDismiss: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, content: <#T##() -> View#>)
        .sheet(isPresented: $showSheet) {
            RandomScreen(model: $selectedModel)
        }


    }
}

fileprivate struct RandomScreen: View {
    
    @Binding var model: RandomModel
    
    var body: some View {
        Text(model.title)
            .modifier(BtnRegular())
    }
}

fileprivate struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcampUsingBinding()
    }
}
