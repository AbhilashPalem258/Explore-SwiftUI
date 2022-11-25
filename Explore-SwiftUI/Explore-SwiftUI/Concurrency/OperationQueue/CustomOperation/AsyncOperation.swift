//
//  AsyncOperation.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 31/10/22.
//

import Foundation
import SwiftUI

class AsyncOperation: Operation {
    
    private let stateQueue = DispatchQueue(label: "com.asyncoperation.threadsafety", attributes: .concurrent)
    
    private var _state: State = .ready
    
    var state: State {
        get {
            stateQueue.sync {
                return _state
            }
        }
        set {
            let oldState = _state
            willChangeValue(forKey: _state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
            stateQueue.sync(flags: .barrier) {
                _state = newValue
            }
            didChangeValue(forKey: _state.keyPath)
            didChangeValue(forKey: oldState.keyPath)
        }
    }
    
//    var state: State = .ready {
//        willSet {
//            willChangeValue(forKey: state.keyPath)
//            willChangeValue(forKey: newValue.keyPath)
//        }
//        didSet {
//            didChangeValue(forKey: oldValue.keyPath)
//            didChangeValue(forKey: state.keyPath)
//        }
//    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        state = .executing
        main()
    }
    
    override func cancel() {
        state = .finished
    }
}
extension AsyncOperation {
    enum State: String {
        case ready
        case executing
        case finished
        
        var keyPath: String {
            "is" + rawValue.capitalized
        }
    }
}

class AsyncOperation1: AsyncOperation {
    override func main() {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0..<7 {
                Thread.sleep(forTimeInterval: 1)
                print("✈️ number: \(i)")
            }
            self.state = .finished
        }
    }
}

class AsyncOperation2: AsyncOperation {
    override func main() {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 30..<37 {
                Thread.sleep(forTimeInterval: 1)
                print("🚀 number: \(i)")
            }
            self.state = .finished
        }
    }
}

class AsyncOperationDemo: NSObject {
    
    var operation1Context = UnsafeMutableRawPointer.allocate(byteCount: 4 * 4, alignment: 1)
    var operation2Context = UnsafeMutableRawPointer.allocate(byteCount: 4 * 4, alignment: 2)
    
    private var tokens = Set<NSKeyValueObservation>()
    func startOperation() {
        
        let operation1 = AsyncOperation1()
        let operation2 = AsyncOperation2()
        
        operation1.observe(\.isFinished, options: [.initial, .new]) { operation, change in
            print("✅ isFinished changed for Operation 1: \(String(describing: change.newValue!))")
        }
        .append(storage: &tokens)
        
        operation1.observe(\.isExecuting, options: [.initial, .new]) { operation, change in
            print("🐢 isExecuting changed for Operation 1: \(String(describing: change.newValue!))")
        }
        .append(storage: &tokens)
        
        operation1.observe(\.isReady, options: [.initial, .new]) { operation,
            change in
            print("🐣 isReady changed for Operation 1: \(String(describing: change.newValue!))")
        }
        .append(storage: &tokens)
        
        operation2.observe(\.isFinished, options: [.initial, .new]) { operation, change in
            print("✅ isFinished changed for Operation 2: \(String(describing: change.newValue!))")
        }
        .append(storage: &tokens)
        
        operation2.observe(\.isExecuting, options: [.initial, .new]) { operation, change in
            print("🐢 isExecuting changed for Operation 2: \(String(describing: change.newValue!))")
        }
        .append(storage: &tokens)
        
        operation2.observe(\.isReady, options: [.initial, .new]) { operation,
            change in
            print("🐣 isReady changed for Operation 2: \(String(describing: change.newValue!))")
        }
        .append(storage: &tokens)
//
//        operation1.addObserver(self, forKeyPath: "isFinished", options: [.new, .initial, .old], context: operation1Context)
//        operation1.addObserver(self, forKeyPath: "isExecuting", options: [.new, .initial, .old], context: operation1Context)
//        operation1.addObserver(self, forKeyPath: "isReady", options: [.new, .initial, .old], context: operation1Context)
//
//        operation2.addObserver(self, forKeyPath: "isFinished", options: [.new, .initial, .old], context: operation2Context)
//        operation2.addObserver(self, forKeyPath: "isExecuting", options: [.new, .initial, .old], context: operation2Context)
//        operation2.addObserver(self, forKeyPath: "isReady", options: [.new, .initial, .old], context: operation2Context)
        
        let operationQueue = OperationQueue()
        operation2.addDependency(operation1)
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "isFinished":
            print("✅ isFinished changed for Operation \(context == operation1Context ? 1 : 2): \(String(describing: change?[.newKey] as! Bool))")
        case "isExecuting":
            print("🐢 isExecuting changed for Operation \(context == operation1Context ? 1 : 2): \(String(describing: change?[.newKey] as! Bool))")
        case "isReady":
            print("🐢 isReady changed for Operation \(context == operation1Context ? 1 : 2): \(String(describing: change?[.newKey] as! Bool))")
        default:
            break
        }
    }
}

struct AsyncOperationView: View {
    let viewModel = AsyncOperationDemo()
    var body: some View {
        VStack {
            Button("Start") {
                viewModel.startOperation()
            }
        }
    }
}

extension NSKeyValueObservation {
    func append(storage: inout Set<NSKeyValueObservation>) {
        storage.insert(self)
    }
}
