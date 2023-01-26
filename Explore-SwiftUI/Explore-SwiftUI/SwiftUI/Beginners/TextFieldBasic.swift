//
//  TextFieldBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/12/22.
//

import SwiftUI
/*
 Source:
 https://www.youtube.com/watch?v=-_-BNwUZrrc&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=36
 
 Definition:
 
 Notes:
 */
struct TextFieldBasic: View {
    
    @State private var tfText: String = ""
    @State private var savedTexts: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Placeholder text", text: $tfText)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.cornerRadius(10))
                
                Button {
                    savedTexts.append(tfText)
                } label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(isTextAppropriate() ? .purple : .gray)
                        .cornerRadius(10)
                }
                .disabled(!isTextAppropriate())
                
                List {
                    Section {
                        ForEach(savedTexts, id: \.self) { text in
                            Text(text)
                        }
                    } header: {
                        Text("Saved Texts")
                    }
                }
                
                Spacer()
            }
            .navigationTitle(Text("TextField Bootcamp!"))
        }
    }
    
    
    func isTextAppropriate() -> Bool {
        return tfText.count > 3 && tfText.count < 11
    }
}

struct TextFieldBasic_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBasic()
    }
}
