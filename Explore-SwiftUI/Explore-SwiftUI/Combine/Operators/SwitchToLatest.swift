//
//  SwitchToLatest.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 03/08/22.
//

import Combine
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/operators/operatorsTransformersBlockers/operatorsswitchtolatest.html
 
 Definition:
 
 Whereas .flatMap makes a publisher, .switchToLatest expects a publisher as the value that it receives from upstream.

 Whereas .flatMap retains the publishers that it makes, .switchToLatest throws away all but the most recent publisher that it receives.
 
 Notes:
 */

class SwitchToLatestViewModel: ObservableObject {
    @Published var count = [Int]()
    var btnClick = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        self.btnClick
            .map {[weak self] _ -> AnyPublisher<Int, Never> in
                self?.count.removeAll()
                return Timer.publish(every: 1.0, on: .main, in: .common)
                    .autoconnect()
                    .scan(0) { count, _ in
                        count + 1
                    }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink {[weak self] item in
                self?.count.append(item)
            }
            .store(in: &cancellables)
    }
}

struct SwitchToLatest: View {
    
    @StateObject private var vm = SwitchToLatestViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("User Move")
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding()
                .background(.blue)
                .cornerRadius(10)
                .onTapGesture {
                    vm.btnClick.send(Int.random(in: 1...18))
                }
            ForEach(vm.count, id: \.self) { item in
                Text("\(item)")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            Spacer()
        }
    }
}

struct SwitchToLatest_Previews: PreviewProvider {
    static var previews: some View {
        SwitchToLatest()
    }
}
