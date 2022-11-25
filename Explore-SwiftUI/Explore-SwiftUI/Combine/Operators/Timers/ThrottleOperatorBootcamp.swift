//
//  ThrottleOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/08/22.
//

import Combine
import Foundation
import SwiftUI

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
