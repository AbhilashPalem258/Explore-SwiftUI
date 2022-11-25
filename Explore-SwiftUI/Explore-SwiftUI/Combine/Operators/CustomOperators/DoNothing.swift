//
//  DoNothing.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/10/22.
//

import Combine
import Foundation

extension Publisher {
    func doNothing() {
        
    }
}

struct DoNothing<Upstream: Publisher>: Publisher {
    typealias Output = Upstream.Output
    typealias Failure = Upstream.Failure
    let upstream: Upstream
    
    func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input {
        subscriber.receive(subscription: Inner(downstream: subscriber))
    }
    
    class Inner<S: Subscriber>:  Subscription, Subscriber where S.Input == Output, S.Failure == Failure {
        
        var upstream: Subscription?
        var downstream: S?
        
        init(downstream: S) {
            self.downstream = downstream
        }
        
        //Subscription Methods
        func request(_ demand: Subscribers.Demand) {
            self.upstream?.request(demand)
        }
        
        func cancel() {
            self.upstream?.cancel()
            self.upstream =  nil
            self.downstream = nil
        }
        
        //Subscriber Methods
        func receive(subscription: Subscription) {
            self.upstream = subscription
            self.downstream?.receive(subscription: self)
        }
        
        func receive(_ input: Output) -> Subscribers.Demand {
            return self.downstream?.receive(input) ?? .unlimited
        }
        
        func receive(completion: Subscribers.Completion<Failure>) {
            self.downstream?.receive(completion: completion)
            self.downstream = nil
            self.upstream = nil
        }
    }

}

