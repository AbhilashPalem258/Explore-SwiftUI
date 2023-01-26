//
//  CollectionExtension.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 30/11/22.
//

import Foundation

/*
 Source:
 https://harshil.net/blog/swift-sequence-collection-array#:~:text=O(n).-,Collection,-While%20in%20practise
 
 Definition:
 A sequence whose elements can be traversed multiple times, nondestructively, and accessed by an indexed subscript.
 
 protocol Collection: Sequence {
     associatedtype Element
     associatedtype Index: Comparable
     associatedtype Indices: Collection
     associatedtype SubSequence: Collection
     
     var startIndex: Index { get }
     var endIndex: Index { get }
     var indices: Indices { get }
     
     func index(after i: Index) -> Index
     
     subscript(position: Index) -> Element { get }
     subscript(bounds: Range<Index>) -> SubSequence { get }
 }
 
To add Collection conformance to your type, you must declare at least the following requirements:
- The startIndex and endIndex properties
- A subscript that provides at least read-only access to your type’s elements
- The index(after:) method for advancing an index into your collection

 
 Notes:
 -  In addition to the operations that collections inherit from the Sequence protocol, you gain access to methods that depend on accessing an element at a specific position in a collection
 
 - The fundamental improvement over Sequence is that a collection lets you access values at any given position, rather than just the one after the one you requested last
 
 - Subscripting a single index returns a single value. Subscripting a range of indices doesn’t return an Array, however, but rather a SubSequence. A collection can use a custom subsequence type, but the standard library provides a good default with the Slice type
 
 - Slices store the entirety of their backing collections and information regarding the subset of them to be used
 
 - Thanks to Swift’s copy-on-write behaviour for all of the standard library collections, this generally doesn’t involve creating an actual copy, but rather the compiler manages multiple references to the same underlying storage transparently, creating actual copies only as needed, when a mutation occurs. This retains value semantics from a Swift developer’s perspective, while optimising memory usage as well. This is where a lot of the power of collections comes into play, allowing you to subscript a range of values with little memory overhead.
 
 - Slices Share Indices: A collection and its slices share the same indices. An element of a collection is located under the same index in a slice as in the base collection, as long as neither the collection nor the slice has been mutated since the slice was created.
 
 - Slices Inherit Collection Semantics: A slice inherits the value or reference semantics of its base collection. That is, when working with a slice of a mutable collection that has value semantics, such as an array, mutating the original collection triggers a copy of that collection and does not affect the contents of the slice
 
 - To check whether a collection is empty, use its isEmpty property instead of comparing count to zero. Unless the collection guarantees random-access performance, calculating count can be an O(n) operation
 */

//MARK: - Selecting and Excluding Elements
extension Collection where Self.SubSequence == Self {
    /*
     Time Complexity: O(1)
     Space Complexity: O(1)
     */
    mutating func popFirstExt() -> Self.Element? {
        guard !isEmpty else {
            return nil
        }
        let element = first!
        self = self[index(after: startIndex)..<endIndex]
        return element
    }
    
    /*
     Time Complexity: O(1)
     Space Complexity: O(1)
     */
    @discardableResult
    mutating func removeFirstExt() -> Self.Element {
        precondition(!isEmpty, "Can't remove items from empty collection")
        let element = first!
        self = self[index(after: startIndex)..<endIndex]
        return element
    }
    
    /*
     Time Complexity: Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the specified number of elements.
     Space Complexity: O(1)
     */
    mutating func removeFirstExt(_ k: Int) {
        precondition(k >= 0, "Number of elements to remove should be non-negative")
        guard let idx = index(startIndex, offsetBy: k, limitedBy: endIndex) else {
            preconditionFailure("Can't remove more items from collection than it contains")
        }
        self = self[idx..<endIndex]
    }
}

//MARK: - Selecting and Excluding Elements
extension Collection {
    // O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance.
    func formIndexExt(_ i: inout Index, offsetBy distance: Int) {
        i = index(i, offsetBy: distance)
    }
    
    // O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance.
    func formIndexExt(_ i: inout Index, offsetBy distance: Int, limitedBy limit: Index) -> Bool {
        if let advancedIndex = index(i, offsetBy: distance, limitedBy: limit) {
            i = advancedIndex
            return true
        }
        i = limit
        return false
    }
}

//MARK: - Splitting and Joining Elements
extension Collection where Element: Equatable {
    func splitExt(separator: Self.Element, maxSplits: Int = Int.max, omittingEmptySubsequence: Bool = true) -> [Self.SubSequence] {
        //TODO
        []
    }
    
    func firstIndexExt(of element: Self.Element) -> Index? {
        for idx in indices {
            if self[idx] == element {
                return idx
            }
        }
        return nil
    }
}
extension Collection {
    var count: Int {
        distance(from: startIndex, to: endIndex)
    }
    
    var first: Element? {
        if endIndex == startIndex {
            return nil
        }
        return self[startIndex]
    }
    
    var isEmpty: Bool {
        startIndex == endIndex
    }
}
//MARK: - Instance Methods
extension Collection {
    /*
     Time Complexity: O(n), where n is the number of elements.
     Space Complexity: O(1)
     */
    func distanceExt(from start: Self.Index, to end: Self.Index) -> Int {
        var start = start
        var count = 0
        while start != end {
            count += 1
            formIndex(after: &start)
        }
        return count
    }
    
    /*
     Time Complexity: O(n), where n is the number of elements.
     Space Complexity: O(1)
     */
    func dropExt(while predicate: (Self.Element) throws -> Bool) rethrows -> Self.SubSequence {
        var start = startIndex
        while try start != endIndex && predicate(self[start]) {
            formIndex(after: &start)
        }
        return self[start..<endIndex]
    }
    
    /*
     Time Complexity: O(1) if the collection conforms to `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of elements to drop from the beginning of the collection.
     Space Complexity: O(1)
     */
    func dropFirstExt(_ k: Int = 1) -> Self.SubSequence {
        let start = index(startIndex, offsetBy: k, limitedBy: endIndex) ?? endIndex
        return self[start..<endIndex]
    }
    
    /*
     Time Complexity: O(1) if the collection conforms to `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of elements to drop from the beginning of the collection.
     Space Complexity: O(1)
     */
    func dropLastExt(_ k: Int = 1) -> Self.SubSequence {
        let end = Swift.max(0, count - k)
        let endId = index(startIndex, offsetBy: end, limitedBy: endIndex) ?? endIndex
        return self[startIndex..<endId]
    }
    
    func firstIndexExt(where predicate: (Self.Element) throws -> Bool) rethrows -> Index? {
        for idx in indices {
            if try predicate(self[idx]) {
                return idx
            }
        }
        return nil
    }
    
    func formIndexExt(after i: inout Index) {
        i = index(after: i)
    }
    
    /*
     Time Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance
     Space Complexity: O(1)
     */
    func indexExt(_ i: Self.Index, offsetBy distance: Int) -> Index {
        var i = i
        for _ in 0..<distance {
            i = index(after: i)
        }
        return i
    }
    
    /*
     Time Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance
     Space Complexity: O(1)
     */
    func indexExt(_ i: Self.Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        var idx = i
        for _ in 0..<distance {
            if idx == limit {
                return nil
            }
            idx = index(after: idx)
        }
        return idx
    }
}

//MARK: - Sequence implementation improvements with collection
extension Collection {
    /*
     Time Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance
     Space Complexity: O(1)
     */
    func prefixExt(_ maxlength: Int = 1) -> Self.SubSequence {
        let end = index(startIndex, offsetBy: maxlength, limitedBy: endIndex) ?? endIndex
        return self[startIndex..<end]
    }
    
    /*
     Time Complexity: O(1)
     Space Complexity: O(1)
     */
    func prefixExt(through position: Index) -> SubSequence {
        self[startIndex..<index(after: position)]
    }
    
    /*
     Time Complexity: O(1)
     Space Complexity: O(1)
     */
    func prefixExt(upTo end: Self.Index) -> SubSequence {
        self[startIndex..<end]
    }
    
    /*
     Time Complexity: O(n)
     Space Complexity: O(1)
     */
    func prefixExt(while predicate: (Element) throws -> Bool) rethrows -> SubSequence {
        var end = startIndex
        while try end != endIndex && predicate(self[end]) {
            end = index(after: end)
        }
        return self[startIndex..<end]
    }
    
    func randomElementExt() -> Element? {
        var generator = SystemRandomNumberGenerator()
        return randomElement(using: &generator)
    }
    
    func randomElementExt<T>(using generator: inout T) -> Element? where T: RandomNumberGenerator {
        guard !isEmpty else {
            return nil
        }
        let random = Int.random(in: 0..<count, using: &generator)
        let idx = index(startIndex, offsetBy: random)
        return self[idx]
    }
    
    /*
     Time Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the absolute value of distance
     Space Complexity: O(1)
     */
    func suffixExt(_ maxlength: Int = 1) -> Self.SubSequence {
        let startVal = Swift.max(0, count - maxlength)
        let startIdx = index(startIndex, offsetBy: startVal, limitedBy: endIndex) ?? endIndex
        return self[startIdx..<endIndex]
    }
    
    /*
     Time Complexity: O(1)
     Space Complexity: O(1)
     */
    func suffixExt(from start: Index) -> SubSequence {
        self[start..<endIndex]
    }
}
fileprivate extension Collection where Self.SubSequence == Slice<Self> {
    subscript(bounds: Range<Index>) -> Self.SubSequence {
        precondition(startIndex <= bounds.lowerBound && bounds.upperBound <= endIndex, "Out Of Bounds")
        return Slice(base: self, bounds: bounds) 
    }
}
