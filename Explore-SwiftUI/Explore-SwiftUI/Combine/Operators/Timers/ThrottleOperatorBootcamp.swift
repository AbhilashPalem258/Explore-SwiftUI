//
//  ThrottleOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/08/22.
//

import Combine
import Foundation
import SwiftUI

/*
Throttle always emits first element and starts sending recent or first value in interval starting from second element
 
 Measure Interval:
 - Time intervals are reported as Stride structs; the actual time is the struct’s magnitude property, whose size depends on the scheduler. For a DispatchQueue, it is an Int reporting nanoseconds
 
    .measureInterval(using: DispatchQueue.main)
    .map {Double($0.magnitude)/1000000000}
 */
fileprivate struct DataService {
    func makeThrottlePublisher() -> AnyPublisher<Int, Never> {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { prev, _ in
                prev + 1
            }
//            .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
            .throttle(for: 5, scheduler: DispatchQueue.main, latest: false)
            .eraseToAnyPublisher()
    }
}

fileprivate class ViewModel: ObservableObject {
    let dataService: DataService = .init()
    private var cancellables = Set<AnyCancellable>()
    @Published var items = [String]()
    
    func startPublishing() {
        dataService.makeThrottlePublisher()
            .sink {[weak self] val in
                self?.items.append("\(val)")
            }
            .store(in: &cancellables)
    }
}

struct ThrottleBootcamp: View {
    
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

struct ThrottleBootcamp_previews: PreviewProvider {
    static var previews: some View {
        ThrottleBootcamp()
    }
}
