//
//  TextBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 06/12/22.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
//            .font(.title)
//            .fontWeight(.bold)
//            .bold()
//            .underline()
            .underline(true, color: .green)
            .strikethrough(true, color: .brown)
            .font(.system(size: 23, weight: .semibold, design: .rounded))
            .italic()
//            .baselineOffset(30) // Space below everyline line text
            .baselineOffset(-30) // Space above everyline line text
            .kerning(0) // Space b/w characters
            .multilineTextAlignment(.center) // alignment
            .foregroundColor(.red)
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
