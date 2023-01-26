//
//  BidirectionalCollectionExtension.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 01/12/22.
//

import Foundation

/*
 Source:
 
 Definition:
 A collection that supports backward as well as forward traversal.
 
 Notes:
 */
extension BidirectionalCollection {
    /*
     Time Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(k), where k is the resulting distance
     Space Complexity: O(1)
     */
    func distance(from start: Index, to end: Index) -> Int {
        var count = 0, start = start
        
        if start < end {
            while start != end {
                count += 1
                start = index(after: start)
            }
        } else if start > end {
            while start != end {
                count -= 1
                start = index(before: start)
            }
        }
        
        return count
    }
    
    func dropLast(_ k: Int = 1) -> Self.SubSequence {
        precondition(k >= 0, "Can't drop a negative number of elements from collection")
        let lastIdx = index(endIndex, offsetBy: -k, limitedBy: startIndex) ?? startIndex
        return self[startIndex..<lastIdx]
    }
    
    func formIndex(after i: inout Index) {
        i = index(after: i)
    }
    
    func formIndex(before i: inout Index) {
        i = index(before: i)
    }
    
    func index(_ i: Index, offsetBy distance: Int) -> Index {
        var i = i
        if distance > 0 {
            for _ in 0..<distance {
                i = index(after: i)
            }
        } else {
            for _ in stride(from: 0, through: distance, by: -1) {
                i = index(before: i)
            }
        }
        return i
    }
    
    func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        var i = i
        if distance > 0 {
            for _ in 0..<distance {
                if i == limit {
                    return nil
                }
                i = index(after: i)
            }
        } else {
            for _ in stride(from: 0, to: distance, by: -1) {
                if i == limit {
                    return nil
                }
                i = index(before: i)
            }
        }
        return i
    }
    
    func last(where predicate: (Self.Element) throws -> Bool) rethrows -> Self.Element? {
        var idx = index(before: endIndex)
        while idx >= startIndex {
            let element = self[idx]
            if try predicate(self[idx]) {
                return element
            }
            idx = index(before: idx)
        }
        return nil
    }
    
    func popLast() -> Self.Element? {
        if isEmpty {
            return nil
        }
        
        let idx = index(before: endIndex)
        return self[idx]
    }
    
//    func reversed() -> ReversedCollection<Self> {
//        ReversedCollection(_base: self)
//    }

    func suffix(_ maxLength: Int) -> Self.SubSequence {
        precondition(maxLength >= 0, "Can't take a suffix of negative length from collection")
        let startIdx = index(endIndex, offsetBy: -maxLength, limitedBy: startIndex) ?? startIndex
        return self[startIdx..<endIndex]
    }
}

extension BidirectionalCollection where Self.Element: Equatable {
    func lastIndexExt(of element: Self.Element) -> Self.Index? {
        var idx = index(before: endIndex)
        while idx >= startIndex {
            let current = self[idx]
            if current == element {
                return idx
            }
            idx = index(before: idx)
        }
        return nil
    }
    
    func lastIndex(where predicate: (Self.Element) throws -> Bool) rethrows -> Index? {
        var idx = index(before: endIndex)
        while idx >= startIndex {
            let current = self[idx]
            if try predicate(current) {
                return idx
            }
            idx = index(before: idx)
        }
        return nil
    }
    
}

extension BidirectionalCollection where Self.SubSequence == Self {
    mutating func removeLast() -> Self.Element {
        let element = last!
        self = self[startIndex..<index(before: endIndex)]
        return element
    }
    
    mutating func removeLast(_ k: Int) {
        if k == 0 { return }
        precondition(k > 0, "Number of elements to remove can't be negative")
        guard let endIdx = index(endIndex, offsetBy: -k, limitedBy: startIndex) else {
            preconditionFailure("Can't remove more items from a collection than it contains")
        }
        self = self[startIndex..<endIdx]
    }
}
