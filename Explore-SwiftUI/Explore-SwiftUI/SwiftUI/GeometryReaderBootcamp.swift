//
//  GeometryReaderBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Color.red
                    .frame(width: geometry.size.width * 0.6666)
                Color.blue
            }
            .ignoresSafeArea()
        }
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
