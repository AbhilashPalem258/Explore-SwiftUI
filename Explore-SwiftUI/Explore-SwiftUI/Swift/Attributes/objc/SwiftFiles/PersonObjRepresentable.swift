//
//  PersonObjRepresentable.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/11/22.
//

import Foundation
import SwiftUI

struct PersonObjcView: View {
    
    @State private var showObjCScreen = false
    
    var body: some View {
        VStack {
            Button {
                showObjCScreen = true
            } label: {
                Text("Present ObjC VC")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.black)
                    .cornerRadius(10.0)
            }
        }
        .sheet(isPresented: $showObjCScreen) {
            print("Dismissed Objc Screen")
        } content: {
            PersonObjCRepresentable()
        }

    }
}

struct PersonObjCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = PersonObjCVC()
        return vc
    }
}
