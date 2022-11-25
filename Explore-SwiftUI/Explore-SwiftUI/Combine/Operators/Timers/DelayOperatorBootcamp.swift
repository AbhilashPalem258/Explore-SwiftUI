//
//  DelayOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/08/22.
//

import Combine
import Foundation
import SwiftUI

/*
 Source:
 
 Definition:
 .delay (Publishers.Delay) inserts a pause between the time a value is received from upstream and the time it is passed on downstream. The parameters are:

 for:
 The length of the delay. You can write an expression such as .seconds(1), .milliseconds(100), and so forth; if you supply an Int or Double literal, it will be taken to mean seconds.
 
 tolerance:
 The permitted tolerance. It has the same type as for:. Optional; you’ll usually omit it.
 
 scheduler:
 The queue or runloop on which the delay will be measured. You’ll supply a DispatchQueue, an OperationQueue, or a RunLoop; the usual value is DispatchQueue.main.
 
 options:
 Optional. You’ll usually omit it.
 
 Notes:
 */

fileprivate let df: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .long
    
    return formatter
}()

fileprivate struct DataService {
    
    let df: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        
        return formatter
    }()
    
    func makeDelayPublisher() -> AnyPublisher<Date, Never> {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .handleEvents(receiveOutput: { value in
                print("Sending Timestamp \(df.string(from: value)) to delay()")
            })
//            .delay(for: <#T##SchedulerTimeIntervalConvertible & Comparable & SignedNumeric#>, tolerance: <#T##(SchedulerTimeIntervalConvertible & Comparable & SignedNumeric)?#>, scheduler: <#T##Scheduler#>, options: <#T##Scheduler.SchedulerOptions?#>)
            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
fileprivate class ViewModel: ObservableObject {
    
    @Published var items: [String] = []
    private let dataservice = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func startPublishing() {
        dataservice.makeDelayPublisher()
            .sink { completion in
                self.items.append("Completion: \(completion)")
            } receiveValue: { date in
                self.items.append("At \(df.string(from: .now)) received value, Timestamp \(df.string(from: date)) Sent:\(String(format: "%.2f", Date.now.timeIntervalSince(date))) secs ago \n")
            }
            .store(in: &cancellables)
    }
}

struct DelayOperatorBootcamp: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.items, id: \.self) { item in
                    Text(item)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
            }
        }
        .onAppear {
            vm.startPublishing()
        }
    }
}

struct DelayOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DelayOperatorBootcamp()
    }
}
