//
//  ThreeDotLoading.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/07/22.
//

import Foundation
import SwiftUI

struct ThreeDotLoading: View {
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State var selection: Int = 0
    
    var body: some View {
        HStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 10)
                .offset(y: selection == 1 ? -20 : 0)
               
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 10)
                .offset(y: selection == 2 ? -20 : 0)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 10, height: 10)
                .offset(y: selection == 3 ? -20 : 0)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut) {
                selection = selection > 3 ? 1 : selection + 1
            }
        }
    }
}

struct ThreeDotLoading_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotLoading()
    }
}
