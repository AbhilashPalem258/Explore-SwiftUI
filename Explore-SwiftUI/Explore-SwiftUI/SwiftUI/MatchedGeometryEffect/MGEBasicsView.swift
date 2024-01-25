//
//  MGEBasicsView.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 20/06/23.
//

import SwiftUI

struct MGEBasicsView: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 150, height: 100)
                
                Rectangle()
                    .fill(.green.opacity(0.6))
                    .frame(width: 100, height: 50)
            }
        }
    }
}

struct MGEBasicsView_Previews: PreviewProvider {
    static var previews: some View {
        MGEBasicsView()
    }
}
