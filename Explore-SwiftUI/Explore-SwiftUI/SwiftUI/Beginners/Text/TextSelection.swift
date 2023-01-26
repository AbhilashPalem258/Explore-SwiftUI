//
//  TextSelection.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI

struct TextSelection: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .textSelection(.disabled)
            .textSelection(.enabled)
    }
}

struct TextSelection_Previews: PreviewProvider {
    static var previews: some View {
        TextSelection()
    }
}
