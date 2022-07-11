//
//  SampleTabBar.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

struct SampleTabBar: View {
    
    private let categories = ["Home", "New Items", "Profile"]
    @State private var selectedCategory = ""
    @Namespace var namespace
    
    var body: some View {
        VStack {
            HStack {
                ForEach(categories, id: \.self) { category in
                    ZStack(alignment: .bottom) {
                        if selectedCategory == category {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.red)
                                .matchedGeometryEffect(id: "subcategory", in: namespace)
                                .frame(width: 55, height: 4)
                                .offset(y: 10)
                                
                        }
                        
                        Text(category)
                            .font(.headline.weight(.bold))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct SampleTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SampleTabBar()
    }
}
