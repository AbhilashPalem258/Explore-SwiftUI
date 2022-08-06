//
//  AdvancedCombineBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/07/22.
//

import Combine
import Foundation
import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:

 */

class AdvancedCombineDataService {
//    @Published var basicPublisher: Int = 0
//    let currentValuePublisher = CurrentValueSubject<Int, Error>(0)
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    func publishFakeData() {
        let arr =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        for index in 0..<arr.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 1)) {[weak self] in
//                self.basicPublisher = arr[index]
//                self?.currentValuePublisher.send(arr[index])
                self?.passThroughPublisher.send(arr[index])
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    let dataservice = AdvancedCombineDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
//        dataservice.$basicPublisher
//        dataservice.currentValuePublisher
        dataservice.passThroughPublisher
        
            // Sequence Operations
            /*
             .first() //output: 1
             .first(where: { val in
                 val > 5
             }) //output: 6
             */
//            .tryFirst(where: { val in
//                <#code#>
//            })
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Failure \(error)")
                }
            } receiveValue: { item in
                self.data.append("\(item)")
            }
            .store(in: &cancellables)
    }
}

struct AdvancedCombineBootcamp: View {
    @StateObject var vm = AdvancedCombineBootcampViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) { item in
                    Text(item)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                }
            }
        }
    }
}
struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}
