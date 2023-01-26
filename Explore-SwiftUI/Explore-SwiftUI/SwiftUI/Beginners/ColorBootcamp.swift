//
//  ColorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/12/22.
//

import SwiftUI

struct ColorBootcamp: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
//                Color.primary
//                Color(UIColor.secondarySystemBackground)
                Color("AbhilashColor")
            )
            .frame(width: 300, height: 200)
//            .shadow(radius: 10.0)
            .shadow(color:  Color("AbhilashColor").opacity(0.4), radius: 10, x: 10, y: 10)
    }
}

struct ColorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ColorBootcamp()
    }
}
