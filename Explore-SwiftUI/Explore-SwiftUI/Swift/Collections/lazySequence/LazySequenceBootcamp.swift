//
//  LazySequenceBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 22/11/22.
//

import SwiftUI

// Start: Dev Documentation - LazySequenceProtocol
extension Sequence {
    func scan<Result>(initial: Result, nextPartialResult: (Result, Self.Element) -> Result) -> [Result] {
        var result = [initial]
        for element in self {
            result.append(nextPartialResult(result.last!, element))
        }
        return result
    }
}
struct LazyScanSequence<Base: Sequence, Result>: LazySequenceProtocol {
    let initial: Result
    let base: Base
    let nextPartialResult: (Result, Base.Element) -> Result
    
    func makeIterator() -> Iterator {
        Iterator(base: base.makeIterator(), nextElement: initial, nextPartialResult: nextPartialResult)
    }
    
    struct Iterator: IteratorProtocol {
        var base: Base.Iterator
        var nextElement: Result?
        let nextPartialResult: (Result, Base.Element) -> Result

        mutating func next() -> Result? {
            nextElement.map { result in
                nextElement = base.next().map { element in
                    nextPartialResult(result, element)
                }
                return result
            }
        }
    }
}

extension LazySequenceProtocol {
    func scan<Result>(initial: Result, nextPartialResult: @escaping (Result, Self.Element) -> Result) -> LazyScanSequence<Self, Result> {
        LazyScanSequence(initial: initial, base: self, nextPartialResult: nextPartialResult)
    }
}
// End: Dev Documentation - LazySequenceProtocol

/*
 Source:
 https://www.appsloveworld.com/swift/100/87/implementing-lazycollectionprotocol
 
 Definition:
 
 Notes:
 - Lazy sequences can be used to avoid needless storage allocation and computation, because they use an underlying sequence for storage and compute their elements on demand.
 */

fileprivate class ViewModel: ObservableObject {
    init () {
        let scanned = [1,2,4].lazy.scan(initial: 0) { result, element in
            result + element
        }
        print(scanned.first)
    }
}

struct LazySequenceBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LazySequenceBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LazySequenceBootcamp()
    }
}
