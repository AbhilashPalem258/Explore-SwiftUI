//
//  AppendAndPrependOperator.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 06/08/22.
//
import Combine
import Foundation
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/operators/operatorsJoiners/operatorsappend.html
 
 Definition:
 
 - .append (Publishers.Concatenate) takes a publisher as a parameter; it is also applied to a publisher (obviously). Both publishers must have the same Output and Failure generic types.
 - To enforce the policy of making these values arrive sequentially, this operator doesn’t subscribe to the second publisher until it receives the first publisher’s .finished completion.
 - Conversely, if it never receives .finished completion from the first publisher, it just keeps publishing the first publisher’s values and never subscribes to the second publisher.
 - If the second publisher sends a .finished completion, this operator sends a .finished completion.
 - If either publisher emits a failure, this publisher cancels the other publisher and passes the failure on downstream
 - .append also comes in two convenience forms. The parameter, instead of being a publisher, can be a sequence of values or simply a variadic (a comma-separated list of values). So in this example it would be legal to write .append([10,20,30]) or even .append(10,20,30).

 
 - .prepend (Publishers.Concatenate) is exactly like .append — indeed, it is the very same operator under the hood — except that the meanings of the publishers are reversed. It starts out by subscribing to and publishing the values from the publisher that is its parameter; when that finishes, it subscribes to and publishes the values from the publisher to which it is applied
 
 - You can readily see that .append (and, for that matter, .prepend) is a way to serialize asynchronicity
 Notes:

 */
fileprivate struct DataService {
    func makeAppendPublisher() -> AnyPublisher<Int, Never> {
        [1,2,3].publisher
            .flatMap(maxPublishers: .max(1)) {
                Just($0).delay(for: 1.0, scheduler: DispatchQueue.main)
            }
            .append(Just(100))
            .print()
            .eraseToAnyPublisher()
    }
    
    func makePrependPublisher() -> AnyPublisher<Int, Never> {
        Just(100)
            .prepend(
                [1,2,3].publisher
                    .flatMap(maxPublishers: .max(1)) { val -> AnyPublisher<Int, Never> in
                        Just(val).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
                    }
            )
            .print()
            .eraseToAnyPublisher()
    }
    
    func makeSerializePublisher() -> AnyPublisher<Data, Never> {
        [
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200"
        ]
            .map{URL(string: $0)}
            .compactMap{$0}
            .map {
                URLSession.shared.dataTaskPublisher(for: $0)
                    .tryMap { (data, response) -> Data in
                        if let statuscode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statuscode) {
                            return data
                        }
                        throw URLError(URLError.badServerResponse) 
                    }
                    .replaceError(with: Data())
            }
            .serialize()
            .eraseToAnyPublisher()
            
    }
}

extension Collection where Element: Publisher {
    func serialize() -> AnyPublisher<Element.Output, Element.Failure> {
        guard let start = self.first else {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        return self.dropFirst().reduce(into: start.eraseToAnyPublisher()) {
            $0 = $0.append($1).eraseToAnyPublisher()
        }
    }
}

class AppendAndPrependOperatorBootcampViewModel: ObservableObject {
    @Published var items = [String]()
    @Published var dataItems = [Data]()
    private let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func startPublishing() {
//        dataService.makeAppendPublisher()
        dataService.makePrependPublisher()
            .sink { val in
                self.items.append("\(val)")
            }
            .store(in: &cancellables)
    }
    
    func startSerializePublishing() {
        dataService.makeSerializePublisher()
            .sink { data in
                DispatchQueue.main.async {
                    self.dataItems.append(data)
                }
            }
            .store(in: &cancellables)
    }
    
}

struct AppendAndPrependOperatorBootcamp: View {
    @StateObject private var vm = AppendAndPrependOperatorBootcampViewModel()
    
    @ViewBuilder var appendPrependView: some View {
        Text("Start Append And Prepend")
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
    
    @ViewBuilder var serializeView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(vm.dataItems, id:\.self) { data in
                    Image(uiImage: UIImage(data: data) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
            }
        }
        .onAppear {
            vm.startSerializePublishing()
        }
    }
    
    var body: some View {
        serializeView
    }
}

struct AppendAndPrependOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AppendAndPrependOperatorBootcamp()
    }
}
