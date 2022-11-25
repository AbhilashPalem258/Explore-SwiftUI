//
//  LazyScanCollection.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 22/11/22.
//

import Foundation

//https://www.appsloveworld.com/swift/100/87/implementing-lazycollectionprotocol
struct LazyScanCollection<Base: Collection, Result>: LazyCollectionProtocol where Base.Element == Result {
    
    typealias Index = Base.Index
    
    let initial: Result
    let base: Base
    let nextPartialResult: (Result, Base.Iterator.Element) -> Result
    
    //Iterator Conformance
    func makeIterator() -> Iterator {
        Iterator(nextElement: initial, base: base.makeIterator(), nextPartialresultCallBack: nextPartialResult)
    }
    
    // Collection Conformance
    var startIndex: Index {
        base.startIndex
    }
    
    var endIndex: Index {
        base.endIndex
    }
    
    subscript(position: Index) -> Base.Iterator.Element {
        base[position]
    }
    
    func index(after i: Index) -> Index {
        base.index(after: i)
    }
    
    struct Iterator: IteratorProtocol {
        var nextElement: Result?
        var base: Base.Iterator
        let nextPartialresultCallBack:  (Result, Base.Iterator.Element) -> Result
        
        mutating func next() -> Result? {
            nextElement.map { result in
                nextElement = base.next().map { element in
                    nextPartialresultCallBack(result, element)
                }
                return result
            }
        }
    }
}
extension LazyCollectionProtocol {
    func scan<Result>(initial: Result, nextPartialResult: @escaping (Result, Self.Element) -> Result) -> LazyScanCollection<Self, Result> {
        LazyScanCollection(initial: initial, base: self, nextPartialResult: nextPartialResult)
    }
}
