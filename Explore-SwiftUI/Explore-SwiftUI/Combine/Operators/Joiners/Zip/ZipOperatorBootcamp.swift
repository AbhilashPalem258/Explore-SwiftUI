//
//  ZipOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 05/08/22.
//
import Combine
import Foundation
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/operators/operatorsJoiners/operatorszip.html
 
 Definition:
 
 Notes:
 - Both publishers must have the same Failure generic types, but their Output types can be different
 - When either of those upstream publishers produces a value, this operator puts it in a buffer (effectively a FIFO stack)
 - When both of those upstream publishers have produced a value — that is, any time there is something in both buffers — this operator pops the oldest value from the start of both buffers, combines them into a tuple, and emits the tuple
 - If either upstream publisher emits a .finished completion, then if the buffer for that publisher is empty (because the .zip operator has popped its last value to send it downstream), the .zip operator cancels the other publisher and sends a .finished completion downstream
 - If either upstream publisher sends a failure, this operator immediately cancels the other publisher and sends the completion on downstream.
 

 */
fileprivate struct DataService {
    func makeZipPublisher() -> AnyPublisher<String, Never> {
       [1,2,3].publisher
            .zip(
                ["a", "b"].publisher
                    .flatMap(maxPublishers: .max(1)) { val in
                        Just(val).delay(for: 1, scheduler: DispatchQueue.main)
                    }
            ) {
                "(\($0), \($1))"
            }
            .eraseToAnyPublisher()
    }
    
    func makeZipPublisher2() -> AnyPublisher<String, Never> {
        //When output if different for publishers
        [1,2,3].publisher
            .zip([11,12,13].publisher, [21,22,23].publisher, [31,32,33].publisher)
            .zip([41,42,43].publisher) { "(\($0.0), \($0.1), \($0.2), \($0.3), \($1))"}
            .eraseToAnyPublisher()
    }
    
    func makeZipPublisher3() -> AnyPublisher<[Int], Never> {
        //When output is same for all publishers
       let pubs = [
            [1,2,3].publisher,
            [11,12,13].publisher,
            [21,22,23].publisher,
            [31,32,33].publisher,
            [41,42,43].publisher
        ]
        return pubs.dropFirst().reduce(into: AnyPublisher(pubs[0].map{[$0]})) { initialPub, nextPub in
            initialPub = initialPub.zip(nextPub){i1, i2 -> [Int] in
                return i1 + [i2]
            }.eraseToAnyPublisher()
        }
    }
}

fileprivate class ZipOperatorBootcampViewModel: ObservableObject {
    @Published var items = [String]()
    let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func startPublishing() {
//        dataService.makeZipPublisher()
        dataService.makeZipPublisher2()
//        dataService.makeZipPublisher3()
            .sink {[weak self] val in
                self?.items.append(val)
//                self?.items.append(val.map{String($0)}.joined(separator: ","))
            }
            .store(in: &cancellables)
    }
}

struct ZipOperatorBootcamp: View {
    @StateObject private var vm = ZipOperatorBootcampViewModel()
    var body: some View {
        Text("Start Zip")
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

struct ZipOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ZipOperatorBootcamp()
    }
}
