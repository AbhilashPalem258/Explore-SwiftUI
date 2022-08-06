//
//  MergeOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 04/08/22.
//

import Combine
import Foundation
import SwiftUI

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
//        dataservice.mergedPublisher()
        dataservice.mergeManyPublisher()
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
