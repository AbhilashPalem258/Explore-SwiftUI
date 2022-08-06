//
//  TimerBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/07/22.
//

import Foundation
import SwiftUI

/*
 Source:
 
 https://www.apeth.com/UnderstandingCombine/publishers/publisherstimer.html
 
 Definition:
 
 Notes:
 */

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    //Current Time
    /*
     @State var date: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    //Count Down
    /*
    @State var count: Int = 10
    @State var finishedText = ""
     */
    
    //CountDown date
    @State var timeRemaining: String = ""
//    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
//        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
//        let minute = remaining.minute ?? 0
//        let seconds = remaining.second ?? 0
//        timeRemaining = "\(hour):\(minute):\(seconds)"
        
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minutes = remaining.minute ?? 0
        let seconds = remaining.second ?? 0
        timeRemaining = "\(minutes) minutes \(seconds) seconds"
    }
    
    var body: some View {
        ZStack {
            RadialGradient (
                colors: [Color(.blue), Color(.red)], center: .center,
                startRadius: 5,
                endRadius: 500
            )
            .edgesIgnoringSafeArea(.all)
            
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding(.horizontal)
        }
    
//        .onReceive(timer) { value in
//            date = Date()
//        }
        
//        .onReceive(timer) { _ in
//            if count < 1 {
//                finishedText = "Wow! 🚒"
//            } else {
//                finishedText = "\(count)"
//            }
//            count -= 1
//        }
        
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
