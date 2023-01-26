//
//  UIViewRepresentableBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/07/22.
//

import Foundation
import SwiftUI

struct UIViewRepresentableBootcamp: View {
    var body: some View {
        BasicViewRepresentable(text: "Something re")
    }
}

struct UIViewRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View  {
        UIViewRepresentableBootcamp()
            .preferredColorScheme(.dark)
    }
}


struct BasicViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let text: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.red
        
        let label = UILabel(frame: .init(x: 10, y: 10, width: 200, height: 300))
        label.text = text
        view.addSubview(label)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
