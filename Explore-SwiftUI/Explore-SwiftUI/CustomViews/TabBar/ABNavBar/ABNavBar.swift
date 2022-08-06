//
//  ABNavBar.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/07/22.
//

import Foundation
import SwiftUI

struct ABNavBar: View {
    var body: some View {
        HStack {
            backButton

            Spacer()
            VStack(spacing: 4) {
                Text("Title")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("subTitle")
                    .font(.subheadline)
            }
            Spacer()
            
            backButton
                .opacity(0)
        }
        .accentColor(.white)
        .foregroundColor(.white)
        .padding()
        .background(Color.blue.edgesIgnoringSafeArea(.top))
    }
    
    var backButton: some View {
        Button {
            
        } label: {
            Image(systemName: "chevron.left")
        }
    }
}

struct ABNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ABNavBar()
            Spacer()
        }
    }
}
