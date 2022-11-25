//
//  SequenceBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 18/11/22.
//

import SwiftUI
import MapKit

/*
 Source:
 Collections Basic: https://medium.com/@duarteich/swift-collection-protocols-5218dc09e542
 lazy sequence: https://www.avanderlee.com/swift/lazy-collections-arrays/
 
 Definition:
 
 Notes:
 - A lazy collection postpones executing modifiers until they’re requested. This also means that the outcome values aren’t stored in an output array. In fact, all modifiers are executed again on each item request
 - Swift doesn’t allow for overloading functions with the same name, arguments, and return value within the same type, however a type can overload a function from another type that it inherits from.
 */

/*
protocol IteratorProtocol {
     associatedtype Element
     mutating func next() -> Self.Element?
 }
 */
fileprivate class NumberIterator: IteratorProtocol {
    private let count: Int
    private var current = 0
    init(count: Int) {
        self.count = count
    }
    
    func next() -> Int? {
        if current >= count {
            return nil
        }
        let returnVal = current
        current += 1
        return returnVal
    }
}

/*
 public protocol Sequence {

     associatedtype Element where Self.Element == Self.Iterator.Element
     associatedtype Iterator : IteratorProtocol

     func makeIterator() -> Self.Iterator
 }
 */

fileprivate class NumberSequence: Sequence {
    typealias Iterator = NumberIterator
    
    typealias Element = Int
    
    private let count: Int
    private let iterator: NumberIterator
    init(count: Int) {
        self.count = count
        self.iterator =  NumberIterator(count: self.count)
    }
    
    func makeIterator() -> NumberIterator {
        //This function is called everytime, it starts executing for in loop
        // if the itertor is a reference type, it return same refereence even on second for loop, which already completed. If iterator is a value type, it starts from starting element for every for in loop execution
        return iterator
    }
}

fileprivate class ViewModel: ObservableObject {
    
    init() {
        
//        var iterator = NumberIterator(count: 12)
//        while let i = iterator.next() {
//            print(i)
//        }
        
        let numSequence = NumberSequence(count: 12)
        for i in numSequence {
            print("First seq")
            print(i)
        }
        for i in numSequence {
            print("Second seq")
            print(i)
        }
        
//        for i in numSequence.prefix(3) {
//            print(i)
//        }

//        let arr = Array(1..<10)
//        let doubled = arr.lazy.map{
//            $0 * 2
//        }
//        print(doubled)
//        for i in doubled {
//            print(i)
//        }
    }
    
}

struct SequenceBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SequenceBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SequenceBootcamp()
    }
}
