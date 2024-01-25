//
//  BasicSheet.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 12/12/22.
//

import SwiftUI


// Presentation Detents: https://www.youtube.com/watch?v=sG_udb_7NMc
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-popover-view

struct BasicSheet: View {
    
    @State private var showSecondView: Bool = false
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            
            Button {
                showSecondView = true
            } label: {
                Text("Show")
                    .font(.headline)
                    .foregroundColor(Color.green)
                    .padding()
                    .padding(Edge.Set.horizontal)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
        }
        .popover(isPresented: $showSecondView) {
            SecondView()
        }
//        .sheet(isPresented: $showSecondView) {
//            print("Dismissed Second View")
//        } content: {
//            SecondView()
//        }
//        .fullScreenCover(isPresented: $showSecondView) {
//            print("Dismissed Second View")
//        } content: {
//            SecondView()
//        }

    }
}

fileprivate struct SecondView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
                    .font(.headline)
                    .foregroundColor(Color.red)
                    .padding()
                    .padding(Edge.Set.horizontal)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
        }
    }
}

struct BasicSheet_Previews: PreviewProvider {
    static var previews: some View {
        BasicSheet()
    }
}
