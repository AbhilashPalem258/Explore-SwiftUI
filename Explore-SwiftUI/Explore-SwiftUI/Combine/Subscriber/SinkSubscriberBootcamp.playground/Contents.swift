import UIKit
import Combine

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/subscribers/subscribers.html
 https://www.apeth.com/UnderstandingCombine/publishers/publisherscustom.html
 
 Definition:
 func sink(receiveCompletion: f1, receiveValue: f2) -> AnyCancellable,  f1 and f2 are functions
 func assign(to:on:) -> AnyCancellable
 
 Subscribers.Completion enum specifying the completion message. There are two possible cases:
 .finished — The publisher is telling us that there will be no more values forthcoming because it has finished producing values in good order. For example, a data task publisher sends a .finished completion after it has done whatever networking we asked it to do.
 .failure — The publisher is telling us that there will be no more values forthcoming because it has encountered an unrecoverable failure. The nature of that failure is expressed as an Error object which is this enum case’s associated value.

 The .sink command makes a Subscribers.Sink object, and the .assign command makes a Subscribers.Assign object. However, both .sink and .assign wrap that object up in an AnyCancellable instance, returning that instance.
 
 Both Sink and Assign conform to the Cancellable protocol, meaning that they have a cancel method.
 
 /* Manually Assign Subscriber
  let assign = Subscribers.Assign(object: self.iv, keyPath: \UIImageView.image)
  pub.subscribe(assign)
  let any = AnyCancellable(assign)
  any.store(in:&self.storage)
  */
 
 Notes:
 - A .sink subscriber is the most flexible way to answer that question by responding to the arrival of a value
 
 - On the other side of the coin, .assign can be dangerous: you can end up with a retain cycle. This occurs in the common situation where what you’re assigning to is a property of self. The workaround is to use .sink instead of .assign, because you can use the capture list to specify that self is weak or unowned, breaking the cycle.
 
 - Moreover, AnyCancellable has the remarkable property that it automatically calls cancel() on its wrapped subscriber when it itself goes out of existence. This means that the whole pipeline right back up to the publisher is cancelled when the wrapper is released. In effect, AnyCancellable gives us memory management for the entire pipeline, along with coherent messaging to the publisher that it no longer needs to produce any values.
 
 - Conversely, you need to retain the AnyCancellable object produced by .sink or .assign if you don’t want to risk having the pipeline cancel itself prematurely.
 
 - If we dont store subscriber in storage, AnyCancellable (which we didn’t even bother to capture) went out of existence and sent a cancel() call to the data task publisher before it had a chance to do any networking.
 */

/* One Shot subscriber
 var cancellable: AnyCancellable? // 1
 cancellable = pub.sink(receiveCompletion: {_ in // 2
     cancellable?.cancel() // 3
 }) { image in
     self.imageView.image = image
 }
 */

class Printer<Input, Failure: Error> {
    var subscription: Subscription?
    var completed = false
}
extension Printer: Subscriber {
    func receive(subscription: Subscription) {
        if self.subscription == nil && !self.completed {
            self.subscription = subscription
            subscription.request(.unlimited)
        }
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        print("Printer input value: \(input)")
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        if case let .failure(err) = completion {
            print("Printer Error: \(err)")
        }
        self.subscription = nil
        self.completed = true
    }
}
extension Printer: Cancellable {
    func cancel() {
        self.subscription?.cancel()
        self.subscription = nil
        self.completed = true
    }
}

//example usage
//let pub = [1,2,3,4,5].publisher
//let sub = Printer<Int, Never>()
//pub.subscribe(sub)


struct MyCoolPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        subscriber.receive(subscription: InnerSubscription(subscriber: subscriber))
    }
    
    class InnerSubscription<S: Subscriber>: Subscription where S.Input == Output, S.Failure == Failure {
        func cancel() {
            self.downstream = nil
        }
        
        var downstream: S?
        var limit = Subscribers.Demand.none
        private var nums = Array(Array(1...11).reversed())
        
        init(subscriber: S) {
            self.downstream = subscriber
        }
        
        func request(_ demand: Subscribers.Demand) {
            guard let downstream = downstream else {
                return
            }
            limit += demand
            while let item = nums.popLast(), limit > .none {
                let newdemand = downstream.receive(item)
                self.limit -= 1
                self.limit += newdemand
                if nums.isEmpty {
                    self.downstream?.receive(completion: .finished)
                    cancel()
                }
            }
        }
        
        deinit {
            cancel()
        }
    }
}

//Example usage of custom publisher and subscriber
let pub1 = MyCoolPublisher()
let sub1 = Printer<Int, Never>()
pub1.subscribe(sub1)
