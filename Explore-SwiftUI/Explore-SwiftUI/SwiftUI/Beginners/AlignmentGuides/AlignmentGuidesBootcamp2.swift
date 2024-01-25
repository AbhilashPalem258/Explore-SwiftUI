//
//  AlignmentGuidesBootcamp2.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/01/24.
//

import SwiftUI

/*
 links:
 - https://www.youtube.com/watch?v=fdSGlCgz1fQ
 - https://swiftui-lab.com/alignment-guides/
 
 */

extension HorizontalAlignment {
    enum TwoColumnAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static var twoColumnAlignment: HorizontalAlignment {
        return HorizontalAlignment(TwoColumnAlignment.self)
    }
}

struct AlignmentGuidesBootcamp2: View {
    
    var example1: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Hello World!")
                Text("Sleep Tight")
                    .font(.title2)
            }
            .border(.green)
            .font(.largeTitle)
            Divider()
            Text("Another View")
        }
        .border(.red)
    }
    
    var example2: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                Rectangle()
                    .frame(width: 75, height: 50)
                    .foregroundColor(.blue)
                    .alignmentGuide(.leading) { dimension in
                        50
                    }
            }
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .alignmentGuide(.top) { dimension in
                        -50
                    }
                Rectangle()
                    .frame(width: 50, height: 75)
                    .foregroundColor(.blue)
            }
            ZStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                Rectangle()
                    .frame(width: 50, height: 75)
                    .foregroundColor(.blue)
                    .alignmentGuide(HorizontalAlignment.center) { dimension in
                       75
                    }
                    .alignmentGuide(VerticalAlignment.center) { dimension in
                       75
                    }
            }
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                Rectangle()
                    .frame(width: 75, height: 50)
                    .foregroundColor(.blue)
                    .alignmentGuide(.leading) { dimension in
                        dimension.width * 0.5
                    }
            }
        }
        .background(.teal)
    }
    
    var example3: some View {
        VStack {
            HStack(alignment: .bottom) {
                Image(systemName: "1.circle.fill")
                Image(systemName: "2.circle.fill")
                    .alignmentGuide(.bottom) { dimension in
                        dimension[VerticalAlignment.center]
                    }
                Image(systemName: "3.circle.fill")
                    .alignmentGuide(.bottom) { dimension in
                        dimension[VerticalAlignment.top]
                    }
            }
            .font(.largeTitle)
            .border(.red)
            Divider()
            HStack(alignment: .bottom, spacing: 0) {
                Text("H")
                    .background(.red)
                Text("2")
                    .font(.title2)
                    .alignmentGuide(.bottom) { dimension in
                        dimension[VerticalAlignment.center] - 5
                    }
                    .background(.red)
                Text("O")
                    .background(.red)
            }
            .font(.largeTitle)
            .border(.green)
            Divider()
            HStack {
                Image(systemName: "lightbulb.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                        dimension[.bottom]
                    })
                
                Text("Energy")
                    .font(.largeTitle)
                    .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                        dimension[.firstTextBaseline]
                    })
            }
        }
    }
    
    var customAlignment: some View {
        VStack(alignment: .twoColumnAlignment) {
            HStack {
                Text("Country Name")
                    .alignmentGuide(HorizontalAlignment.twoColumnAlignment, computeValue: { dimension in
                        dimension[HorizontalAlignment.trailing]
                    })
                Text("Capital")
            }
            .bold()
            HStack {
                Text("Canada")            .bold()
                    .alignmentGuide(HorizontalAlignment.twoColumnAlignment, computeValue: { dimension in
                        dimension[HorizontalAlignment.trailing]
                    })

                Text("Ottawa")
            }
            HStack {
                Text("United States")            .bold()
                    .alignmentGuide(HorizontalAlignment.twoColumnAlignment, computeValue: { dimension in
                        dimension[HorizontalAlignment.trailing]
                    })

                Text("Washington DC")
            }
        }
    }
    
    var body: some View {
        customAlignment
    }
}

#Preview {
    AlignmentGuidesBootcamp2()
}
