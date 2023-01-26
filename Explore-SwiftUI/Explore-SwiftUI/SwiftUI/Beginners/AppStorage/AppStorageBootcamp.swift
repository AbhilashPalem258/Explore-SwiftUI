//
//  AppStorageBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 31/12/22.
//

import SwiftUI

struct AppStorageBootcamp: View {
    
    @AppStorage("UserName") private var name: String = ""
    
    var body: some View {
        ZStack {
//            LinearGradient(colors: [.red, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                TextField("Enter name here...", text: $name)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 10.0, x: 0, y: 10.0)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Saved Text:")
                        .font(.subheadline.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(name)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .cornerRadius(10.0)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct AppStorageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageBootcamp()
    }
}
