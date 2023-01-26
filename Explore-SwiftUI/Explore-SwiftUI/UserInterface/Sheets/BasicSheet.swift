//
//  BasicSheet.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 12/12/22.
//

import SwiftUI


// Presentation Detents: https://www.youtube.com/watch?v=sG_udb_7NMc
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
        .sheet(isPresented: $showSecondView) {
            print("Dismissed Second View")
        } content: {
            SecondView()
        }
//        .fullScreenCover(isPresented: $showSecondView) {
//            print("Dismissed Second View")
//        } content: {
//            SecondView()
//        }

    }
}

fileprivate struct SecondView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button {
                presentationMode.wrappedValue.dismiss()
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
