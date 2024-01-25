//
//  TimeLineViewBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 28/12/22.
//

import SwiftUI

struct TimeLineViewBasic: View {
    var body: some View {
        VStack {
//            TimelineView(.animation) { context in
//            TimelineView(.periodic(from: .now, by: 3)) { context in
            TimelineView(.animation(minimumInterval: 1, paused: false)) { context in
                let date = context.date
                let seconds = Calendar.current.component(.second, from: date)
                
                Circle()
                    .trim(from: 0, to: Double(seconds)/60.0)
                    .stroke(Color.purple, style: StrokeStyle(lineWidth: 10))
                    .rotationEffect(Angle(degrees: -90))
            }
        }
        .padding()
    }
}

struct TimeLineViewBasic_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineViewBasic()
    }
}
