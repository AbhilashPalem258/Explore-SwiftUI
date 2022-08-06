//
//  ControlPublisher.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 01/08/22.
//

import Combine
import Foundation
import UIKit

struct ControlPublisher<T: UIControl>: Publisher {
    typealias Output = T
    typealias Failure = Never
    unowned let control: T
    let event: UIControl.Event
    
    init(control: T, event: UIControl.Event) {
        self.control = control
        self.event = event
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        subscriber.receive(subscription: InnerSubscription(downstream: subscriber, control: control, event: event))
    }
    
    class InnerSubscription<S: Subscriber>: Subscription where S.Input == Output, S.Failure == Failure {
        weak var sender: T?
        let event: UIControl.Event
        var downstream: S?
        init(downstream: S, control: T, event: UIControl.Event) {
            self.event = event
            self.sender = control
            self.downstream = downstream
        }
        
        func request(_ demand: Subscribers.Demand) {
            self.sender?.addTarget(self, action: #selector(doAction), for: event)
        }
        
        @objc func doAction() {
            guard let sender = sender else {
                return
            }
            _ = self.downstream?.receive(sender)
        }
        
        private func finish() {
            self.sender?.removeTarget(self, action: #selector(doAction), for: event)
            self.sender = nil
            self.downstream = nil
        }
        
        func cancel() {
            finish()
        }
        
        deinit {
            finish()
        }
    }
}

protocol ControlWithPublisher: UIControl {}
extension ControlWithPublisher {
    func publisher(event: UIControl.Event = .primaryActionTriggered) -> ControlPublisher<Self> {
        ControlPublisher(control: self, event: event)
    }
}
extension UIControl: ControlWithPublisher {}
