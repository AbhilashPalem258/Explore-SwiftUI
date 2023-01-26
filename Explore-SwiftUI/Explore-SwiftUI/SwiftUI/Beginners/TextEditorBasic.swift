//
//  TextEditorBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/12/22.
//

import SwiftUI
/*
 Source:
 https://www.youtube.com/watch?v=NiiYeoFYiXQ&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=38
 
 Definition:
 
 Notes:
 */
struct TextEditorBasic: View {
    
    @State private var textEditorText: String = ""
    @State private var savedText: String = ""
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $textEditorText)
                    .frame(maxHeight: 300)
                    .foregroundColor(.orange)
                    .background(.blue)
//                    .colorMultiply(.green)
                    .cornerRadius(10.0)
                
                Button {
                    savedText = textEditorText
                } label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(.red)
                        .cornerRadius(10)
                }
                
               Text(savedText)
                
                Spacer()
            }
            .padding()
            .background(LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            .navigationTitle("TextEditor Bootcamp!")
        }
    }
}

struct TextEditorBasic_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorBasic()
    }
}
