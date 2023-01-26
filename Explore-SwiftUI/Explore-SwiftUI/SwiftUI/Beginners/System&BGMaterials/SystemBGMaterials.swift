//
//  SystemBGMaterials.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI

struct SystemBGMaterials: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Spacer()
                    
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                    
                    Image(systemName: "bell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                    
                    Image(systemName: "square.and.arrow.up.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Spacer()
                }
                .padding()
                
                Divider()
                
                Label {
                    Text("Add Participants")
                } icon: {
                    Image(systemName: "person.crop.circle.badge.plus")
                }
                .padding(.bottom)
                
                Spacer()
                    .frame(height: 300)

            }
            .background(.ultraThinMaterial)
//            .background(.thinMaterial)
//            .background(.thickMaterial)
//            .background(.regularMaterial)
//            .background(.ultraThickMaterial)
            .cornerRadius(10.0)
        }
        .ignoresSafeArea()
        .background(
            Image("Damini")
        )
    }
}

struct SystemBGMaterials_Previews: PreviewProvider {
    static var previews: some View {
        SystemBGMaterials()
    }
}
