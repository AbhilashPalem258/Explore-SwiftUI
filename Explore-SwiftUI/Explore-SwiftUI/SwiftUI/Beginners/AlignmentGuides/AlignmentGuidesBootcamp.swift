//
//  AlignmentGuidesBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/01/24.
//

import SwiftUI

/*
 links: https://www.youtube.com/watch?v=7AaAVuWmlqQ
 Notes:
 -
 
 */

struct AlignmentGuidesBootcamp: View {
    
    var basic: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hello World!")
                .background(.blue)
//                .padding(.leading, -20)
//                .offset(x: -20)
                .alignmentGuide(.leading) { dimension in
//                    dimension.width * 0.5
                    dimension.width
                }
            
            Text("This is some other text!")
                .background(.red)
        }
        .background(.orange)
    }
    
    var realWorldUsage: some View {
        VStack(alignment: .leading, spacing: 20) {
            row("Row 1", showIcon: false)
            row("Row 2")
            row("Row 3", showIcon: false)
        }
        .padding(16)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(40)
    }
    
    func row(_ title: String, showIcon: Bool = true) -> some View {
        HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        }
        .background(.red)
        .alignmentGuide(.leading) { dimension in
            showIcon ? 40 : 0
        }
    }
    
    var example3: some View {
        VStack {
            Text("Today's Weather")
                .font(.title)
                .border(.gray)
            HStack {
                Text("🌧")
                Text("Rain & Thunderstorms")
                Text("⛈")
            }
            .alignmentGuide(HorizontalAlignment.center) { _ in  50 }
            .border(.gray)
        }
        .border(.gray)
    }
    
    var body: some View {
        example3
    }
}

#Preview {
    AlignmentGuidesBootcamp()
}
