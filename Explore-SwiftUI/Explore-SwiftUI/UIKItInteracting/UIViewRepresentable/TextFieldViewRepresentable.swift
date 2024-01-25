//
//  TextFieldViewRepresentable.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/07/22.
//

import Foundation
import SwiftUI

//Attributed Text: https://swiftui-lab.com/attributed-strings-with-swiftui/

struct TextFieldViewRepresentableBootcamp: View {
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Text("SwiftUI")
                TextField("Abhilash", text: $text)
                    .frame(height: 55)
                    .background(.black.opacity(0.2))
            }
            
            HStack {
                Text("UIKit")
                TextFieldViewRepresentable(text: $text)
                    .updatePlaceholder("New PlaceHolder !!!")
                    .frame(height: 55)
                    .background(.black.opacity(0.2))
            }
        }
    }
}

struct TextFieldViewRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldViewRepresentableBootcamp()
    }
}

struct TextFieldViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UITextField
    var placeholder: String = "Type Here..."
    let placeholderColor: UIColor = .red
    @Binding var text: String
    
    func getTextField() -> UITextField {
        let tf = UITextField()
        let attributedPlaceHolder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: placeholderColor
        ])
        tf.attributedPlaceholder = attributedPlaceHolder
        return tf
    }

    func makeUIView(context: Context) -> UITextField {
        let tf = getTextField()
        tf.delegate = context.coordinator
        return tf
    }
    
    // From SwiftUI to UIkit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func updatePlaceholder(_ placeholder: String) -> TextFieldViewRepresentable {
        var view = self
        view.placeholder = placeholder
        return view
    }

    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
         
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
