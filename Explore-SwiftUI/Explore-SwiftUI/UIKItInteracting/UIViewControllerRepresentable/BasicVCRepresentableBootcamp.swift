//
//  BasicVCRepresentableBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 17/07/22.
//

import Foundation
import SwiftUI

struct BasicVCRepresentableBootcamp: View {
    @State var showUIScreen = false
    var body: some View {
        VStack {
            Text("SwiftUI View")
            
            Button {
                showUIScreen.toggle()
            } label: {
                Text("Navigate to UIKit")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }

        }
        .sheet(isPresented: $showUIScreen) {
            print("Dismissed UIKIt")
        } content: {
            BasicVCRepresentable(labelText: "From SSwiftUI")
        }

    }
}

struct BasicVCRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BasicVCRepresentableBootcamp()
    }
}

struct BasicVCRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> MyViewController {
        let vc = MyViewController()
        vc.labelText = labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        
    }
}

class MyViewController: UIViewController {
    
    var labelText: String = "ViewController from UIKit"
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        
        let label = UILabel(frame: .zero)
        label.text = labelText
        label.textAlignment = .center
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
