//
//  Printer.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 22/10/22.
//

import Combine
import Foundation

class Printer<Input, Failure: Error>: Subscriber {
    
    var subscription: Subscription?
    var isCompleted = false
    
    func receive(subscription: Subscription) {
        if self.subscription == nil && !isCompleted {
            self.subscription = subscription
            subscription.request(.unlimited)
        }
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        print("Received Input: \(input)")
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        print("Received Completion: \(completion)")
        if case let .failure(error) = completion {
            print("Error: \(error)")
        }
        self.subscription = nil
        isCompleted = true
    }
}
extension Printer: Cancellable {
    func cancel() {
        self.subscription?.cancel()
        self.subscription = nil
        self.isCompleted = true
    }
}


struct TestPrinter {
    private var cancellable: AnyCancellable?
    mutating func test() {
        let subscriber = Printer<Int, Never>()
        [1,2,3,4].publisher
            .subscribe(subscriber)
        self.cancellable = AnyCancellable(subscriber)
    }
}
