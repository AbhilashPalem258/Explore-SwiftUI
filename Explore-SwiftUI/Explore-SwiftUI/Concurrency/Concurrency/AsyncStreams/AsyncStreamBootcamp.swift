//
//  AsyncStreamBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/01/24.
//

import SwiftUI

/*
 links:
 
 Notes:
 - AsyncStream conforms to AsyncSequence, providing a convenient way to create an asynchronous sequence without manually implementing an asynchronous iterator.
 - When there are no further elements to produce, call the continuation’s finish() method. This causes the sequence iterator to produce a nil, which terminates the sequence. The continuation conforms to Sendable, which permits calling it from concurrent contexts external to the iteration of the AsyncStream.
 - An arbitrary source of elements can produce elements faster than they are consumed by a caller iterating over them. Because of this, AsyncStream defines a buffering behavior, allowing the stream to buffer a specific number of oldest or newest elements. By default, the buffer limit is Int.max, which means the value is unbounded.
 
 - init(_ elementType: Element.Type = Element.self,
        bufferingPolicy limit: AsyncStream<Element>.Continuation.BufferingPolicy = .unbounded,
        _ build: (AsyncStream<Element>.Continuation) -> Void
)
 */

fileprivate struct AsyncDataManager {
    
    func performAsyncThrowingStreamTask() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream { continuation in
            self.performTask { value in
                let result = continuation.yield(value)
                switch result {
                case .enqueued(let remaining):
                    //The stream successfully enqueued the element.
                    print("Remaining Elements: \(remaining)")
                case .dropped(let element):
                    //The stream didn’t enqueue the element because the buffer was full.
                    print("Dropped element: \(element)")
                case .terminated:
                    //The stream didn’t enqueue the element because the stream was in a terminal state.
                    print("Stream Terminated")
                @unknown default:
                    fatalError()
                }
            } onFinish: { error in
                continuation.finish(throwing: error)
            }
        }
    }
    
    func performAsyncStreamTask() -> AsyncStream<Int> {
        AsyncStream(Int.self) { continuation in
            self.performTask { value in
                continuation.yield(value)
            } onFinish: { error in
                continuation.finish()
            }
        }
    }
    
    func performTask(completion: @escaping (Int) -> Void, onFinish: @escaping (Error?) -> Void) {
        let items = Array(1...10)
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item)) {
                completion(item)
                
                if item == items.last {
                    onFinish(nil)
                }
            }
        }
    }
}

@MainActor
fileprivate class ViewModel: ObservableObject {
    
    private let dataManager = AsyncDataManager()
    @Published var currentNumber = 0
    
    func onViewAppear() async {
//        dataManager.performTask { [weak self] value in
//            self?.currentNumber = value
//        } onFinish: { error in
//            print(error?.localizedDescription)
//        }
        
//        for await item in dataManager.performAsyncStreamTask() {
//            self.currentNumber = item
//        }
        
        do {
            for try await item in dataManager.performAsyncThrowingStreamTask() {
                self.currentNumber = item
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AsyncStreamBootcamp: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        Text(vm.currentNumber.description)
            .font(.title.bold())
            .onAppear {
//                vm.onViewAppear()
                Task {
                    await vm.onViewAppear()
                }
            }
    }
}

#Preview {
    AsyncStreamBootcamp()
}
