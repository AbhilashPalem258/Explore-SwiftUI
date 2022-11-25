//
//  CombineLatestOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 05/08/22.
//

import Combine
import Foundation
import SwiftUI

/*
 Source:
 
 Definition:
 - Both publishers must have the same Failure generic types, but their Output types can be different. It is sort of like .zip turned upside-down
 
 .zip waits for both upstream publishers to publish and then emits their oldest contributions as a tuple.

 .combineLatest waits for both upstream publishers to publish and then emits their newest contributions as a tuple.
 
 Notes:
 */
fileprivate struct DataService {
    func makeCombineLatestPublisher() -> AnyPublisher<String, Never> {
       [1,2,3].publisher
            .combineLatest(
                ["a", "b"].publisher
                    .flatMap(maxPublishers: .max(1)) { val in
                        Just(val).delay(for: 1, scheduler: DispatchQueue.main)
                    }
            ) {
                "(\($0), \($1))"
            }
            .eraseToAnyPublisher()
    }
    
    func makeCombineLatestPublisher2() -> AnyPublisher<String, Never> {
        //When output if different for publishers
        [1,2,3].publisher
            .combineLatest([11,12,13].publisher, [21,22,23].publisher, [31,32,33].publisher)
            .combineLatest([41,42,43].publisher) { "(\($0.0), \($0.1), \($0.2), \($0.3), \($1))"}
            .print()
            .eraseToAnyPublisher()
    }
    
    func makeCombineLatestPublisher3() -> AnyPublisher<[Int], Never> {
        //When output is same for all publishers
       let pubs = [
            [1,2,3].publisher,
            [11,12,13].publisher,
            [21,22,23].publisher,
            [31,32,33].publisher,
            [41,42,43].publisher,
            [51,52,53].publisher
        ]
        return pubs.dropFirst().reduce(into: AnyPublisher(pubs[0].map{[$0]})) { initialPub, nextPub in
            initialPub = initialPub.combineLatest(nextPub){i1, i2 -> [Int] in
                return i1 + [i2]
            }.print().eraseToAnyPublisher()
        }
    }
    
//    func makeWithLatestFrom() -> AnyPublisher<String, Never> {
//        [1,2,3].publisher
//            .map{value in (value: value, date: Date())}
//            .combineLatest([11,12,12].publisher)
//            .removeDuplicates { $0.0.date == $1.0.date }
//            .map{"(\($0.value),$1)"}
//            .eraseToAnyPublisher()
//    }
}

fileprivate class CombineLatestOperatorBootcampViewModel: ObservableObject {
    @Published var items = [String]()
    let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func startPublishing() {
//        dataService.makeCombineLatestPublisher()
        dataService.makeCombineLatestPublisher2()
//        dataService.makeCombineLatestPublisher3()
            .sink {[weak self] val in
                self?.items.append(val)
//                self?.items.append(val.map{String($0)}.joined(separator: ","))
            }
            .store(in: &cancellables)
    }
}

struct CombineLatestOperatorBootcamp: View {
    @StateObject private var vm = CombineLatestOperatorBootcampViewModel()
    var body: some View {
        Text("Start CombineLatest")
            .font(.system(size: 25, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding()
            .background(.blue)
            .cornerRadius(10)
            .onTapGesture {
                vm.startPublishing()
            }
        
        ForEach(vm.items, id: \.self) { item in
            Text("\(item)")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
        }
        
        Spacer()
    }
}

struct CombineLatestOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CombineLatestOperatorBootcamp()
    }
}
