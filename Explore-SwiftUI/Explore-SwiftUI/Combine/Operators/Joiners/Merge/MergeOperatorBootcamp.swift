//
//  MergeOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 04/08/22.
//

import Combine
import Foundation
import SwiftUI

/*
 Source:
 
 Definition:
 .merge(with:) takes a publisher as a parameter; it is also applied to a publisher (obviously). Both publishers must have the same Output and Failure generic types. Now there are effectively two upstream publishers. When either of those upstream publishers produces a value, this operator passes that value downstream. The two streams of values are interleaved.
 
 This goes on until both upstream publishers have sent a .finished completion. If either publisher sends a .failure completion, this operator cancels the other publisher and sends the failure on downstream.
 
 Notes:
 - There are actually two forms of .merge(with:). If both publishers are of the very same type — two Timer.TimerPublishers, or two Publisher.Sequences, or whatever — that is a Publishers.MergeMany. If they are of different types (but with the same Output and Failure types), that is a Publishers.Merge. However, you won’t normally be conscious of this difference, and in any case you could turn the latter into the former by type-erasing both publishers with .eraseToAnyPublisher.
 
 - The syntax for forming all of them is the same: you say .merge(with:) followed by a comma-separated list of publishers. Behind the scenes, these are actually different operators — Publishers.Merge3, Publishers.Merge4, and so on through Publishers.Merge8. But again, you won’t normally be conscious of that fact
 */


fileprivate struct DataService {
    func makePublisher() -> AnyPublisher<Int, Error> {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .setFailureType(to: Error.self)
            .scan(0) { prev, _ in
                prev + 1
            }
            .eraseToAnyPublisher()
    }
    
    func mergedPublisher() -> AnyPublisher<Int, Error> {
        let pub1 = makePublisher()
        let pub2 = makePublisher().delay(for: 0.5, scheduler: DispatchQueue.main)
        return pub1.merge(with: pub2).eraseToAnyPublisher()
    }
    
    func mergeManyPublisher() -> AnyPublisher<Int, Error> {
        let arr = (1...5).map{ _ in makePublisher()}
        let merged = arr.dropFirst().reduce(into: arr[0]) { initialPublisher, nextPublisher in
            initialPublisher = initialPublisher.merge(with: nextPublisher).eraseToAnyPublisher()
        }
        return merged
    }
}

fileprivate class MergeOperatorBootcampViewModel: ObservableObject {
    @Published var items = [Int]()
    private let dataservice = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func startMerge() {
        dataservice.mergedPublisher()
//        dataservice.mergeManyPublisher()
            .sink { completion in
                if case .failure(_) = completion {
                    print("Error Received: \(completion)")
                }
            } receiveValue: { val in
                self.items.append(val)
            }
            .store(in: &cancellables)
    }
}

struct MergeOperatorBootcamp: View {
    
    @StateObject private var vm = MergeOperatorBootcampViewModel()
    
    var body: some View {
        VStack {
            Text("Start Merge")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding()
                .background(.blue)
                .cornerRadius(10)
                .onTapGesture {
                    vm.startMerge()
                }
            
            ForEach(vm.items, id: \.self) { item in
                Text("\(item)")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            
            Spacer()
        }
    }
}

struct MergeOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MergeOperatorBootcamp()
    }
}
