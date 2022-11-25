//
//  SplittersUsageIntro.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 06/08/22.
//
import Combine
import Foundation
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/operators/operatorsSplitters/operatorsshare.html
 
 Definition:
 
 Notes:
 
 .share() vs .multicast(_)
 internally, a Share object is a Multicast object! .share is just a convenient wrapper for .multicast. But it is convenient, which makes it less likely that you would need to use .multicast explicitly. So why would you use .multicast explicitly? Well, the .multicast inside .share is followed by .autoconnect, so the pipeline starts going as soon as it has a subscriber. If you want the power to set the pipeline going manually by calling connect yourself, you can use .multicast. You might also use .multicast if you want more control over the type of Subject that is being dispensed.
 
 Share Publisher:
 What happens if our shared publisher has multiple downstream pipelines subscribed to it and an operator fails in one of those pipelines? As you know, that causes a cancel message to percolate up the pipeline. But it stops when it reaches the .share operator. So that downstream pipeline is terminated, but the publisher itself keeps on publishing, and any other subscribed downstream pipelines keep receiving values.

 On the other hand, if the last remaining subscriber fails, its cancel does percolate all the way up to the Timer publisher, and the whole pipeline terminates.
 
 NOTE: .share does not transmit backpressure from downstream to upstream; it always performs an unlimited request to the upstream.

 */
fileprivate class DataService {
    
    let mySubject = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    func makeSplitterPublisher() {
        (1...10).publisher
            .map {
                Just($0)
                    .delay(for: 2, scheduler: DispatchQueue.main)
            }
            .flatMap(maxPublishers: .max(1)) { $0 }
            .eraseToAnyPublisher()
            .sink { self.mySubject.send($0) }
            .store(in: &cancellables)
    }
    
    func makeSharePublisher() -> AnyPublisher<Int, Never> {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { prev, _ in
                prev + 1
            }
            .share()
            .eraseToAnyPublisher()
    }
    
    func makeMulticastPublisher() -> AnyPublisher<Int, Never> {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { prev, _ in
                prev + 1
            }
            .multicast(subject: PassthroughSubject())
            .autoconnect()
            .eraseToAnyPublisher()
    }
}

class SplittersUsageIntroBootcampViewModel: ObservableObject {
    
    @Published var items1 = [Int]()
    @Published var items2 = [Int]()
    
    private let dataservice = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func startPublishing() {
        let pub = dataservice.mySubject
        
        pub.sink {[weak self] value in
                self?.items1.append(value)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            pub.sink {[weak self] value in
                    self?.items2.append(value)
                }
            .store(in: &self.cancellables)
        }
        
        dataservice.makeSplitterPublisher()
    }
    
    func startSharePublisher() {
        let pub = dataservice.makeSharePublisher()
        
        pub.sink {[weak self] value in
                self?.items1.append(value)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            pub.sink {[weak self] value in
                    self?.items2.append(value)
                }
            .store(in: &self.cancellables)
        }
    }
    
    func startConnectPublisher() {
        let pub = dataservice.makeMulticastPublisher()
        
        pub.sink {[weak self] value in
                self?.items1.append(value)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            pub.sink {[weak self] value in
                    self?.items2.append(value)
                }
            .store(in: &self.cancellables)
        }
    }
}

struct SplittersUsageIntroBootcamp: View {
    
    @StateObject var vm = SplittersUsageIntroBootcampViewModel()
    
    @ViewBuilder private var publisherView: some View {
        Text("Start Publishing")
            .font(.system(size: 25, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding()
            .background(.blue)
            .cornerRadius(10)
            .onTapGesture {
                vm.startConnectPublisher()
            }
        
        HStack(alignment: .top) {
            VStack {
                ForEach(vm.items1, id: \.self) { item in
                    Text("\(item)")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            VStack {
                ForEach(vm.items2, id: \.self) { item in
                    Text("\(item)")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Spacer()
    }
    
    var body: some View {
        publisherView
    }
}

struct SplittersUsageIntroBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SplittersUsageIntroBootcamp()
    }
}
