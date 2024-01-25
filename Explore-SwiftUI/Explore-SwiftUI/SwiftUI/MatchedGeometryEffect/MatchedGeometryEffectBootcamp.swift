//
//  MatchedGeometryEffectBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

/*
 Source link:
 https://www.youtube.com/watch?v=xGNR7tvDE0Q
 
 Definition:
 Matched Geometry Effect defines a group of views with synchronized geometry using an identifier and namespace we provide
 
 - Transitioning Views
 - @Namespace
 - matchedGeometryEffect method that utilizes the namespace and matches views with Identical ID's
 - Match either the size, position or full frame to transform one view to another
 - Specify Anchor points
 
 - A namespace is a dynamic property type that allows access to a namespace defined by the persistent identity of the object containing the property
 
 Notes:
 

 */

struct MatchedGeometryEffectSample: View {
    
    @State private var isClicked = false
    @Namespace var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.green)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.green)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 250)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectSample()
    }
}


