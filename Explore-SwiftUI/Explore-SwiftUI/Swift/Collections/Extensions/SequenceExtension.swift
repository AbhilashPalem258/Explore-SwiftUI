//
//  SequenceExtension.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 26/11/22.
//

import Foundation
import UIKit

/*
 Source:
 
 Definition:
 
 Notes:
 - A function or method can be declared with the rethrows keyword to indicate that it throws an error only if one of its function parameters throws an error.
 */
//MARK: - Finding Elements. Equatable Conformance
extension Sequence where Element: Equatable {
    
    /*
     Time Complexity: O(n)
     Space Complexity: O(1)
     */
    func containsExt(_ element: Self.Element) -> Bool {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func containsExt(where predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        for item in self {
            if try predicate(item) {
                return true
            }
        }
        return false
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func allSatisfyExt(_ predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        for item in self {
            if try !predicate(item) {
                return false
            }
        }
        return true
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func firstExt(where predicate: (Self.Element) throws -> Bool) rethrows -> Self.Element? {
        for item in self {
            if try predicate(item) {
                return item
            }
        }
        return nil
    }
    
}

//MARK: - Comparable Conformance
extension Sequence where Element: Comparable {
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func minExt() -> Self.Element? {
        var iterator = makeIterator()
        guard var minValue = iterator.next() else {
            return nil
        }
        while let item = iterator.next() {
            if item < minValue {
                minValue = item
            }
        }
        return minValue
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func minExt(by areInIncreasingOrder: (Self.Element, Self.Element) throws -> Bool) rethrows -> Self.Element? {
        var iterator = makeIterator()
        guard var minVal = iterator.next() else {
            return nil
        }
        while let item = iterator.next() {
            if try !areInIncreasingOrder(minVal, item) {
                minVal = item
            }
        }
        return minVal
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func maxExt() -> Self.Element? {
        var iterator = makeIterator()
        guard var maxVal = iterator.next() else {
            return nil
        }
        
        while let item = iterator.next() {
            if item > maxVal {
                maxVal = item
            }
        }
        return maxVal
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func maxExt(by areInIncreasingOrder: (Self.Element, Self.Element) throws -> Bool) rethrows -> Self.Element? {
        var iterator = makeIterator()
        guard var maxVal = iterator.next() else {
            return nil
        }
        while let item = iterator.next() {
            if try areInIncreasingOrder(maxVal, item) {
                maxVal = item
            }
        }
        return maxVal
    }
}

//MARK: - Selecting Elements
extension Sequence {
    func prefixExt(_ maxLength: Int) -> [Self.Element] {
        var result = [Element]()
        var index = 0
        for item in self {
            index += 1
            result.append(item)
            if index >= maxLength {
                break
            }
        }
        return result
    }
    
    /*
     Time Complexity: O(K), where K is the length of the result.
     Space Complexity: O(1)
     */
    func prefixExt(where predicate: (Self.Element) throws -> Bool) rethrows -> [Self.Element] {
        var result = [Element]()
        for item in self {
            if try predicate(item) {
                result.append(item)
            } else {
                break
            }
        }
        return result
    }
    
    func suffixExt(_ maxlength: Int) -> [Self.Element] {
        var elements = [Element]()
        var start = 0, end = 0
        for item in self {
            if (end - start) >= maxlength {
                start += 1
            }
            elements.append(item)
            end += 1
        }
        return Array(elements[start..<end])
    }
}
//MARK: - Excludinng Elements
extension Sequence {
    func dropFirst(_ k: Int = 1) -> [Self.Element] {
        var result = [Self.Element]()
        var index = 0
        for item in self {
            index += 1
            if index > k {
                result.append(item)
            }
        }
        return result
    }
    
    func dropLast(_ k: Int = 1) -> [Self.Element] {
        var elements = [Element]()
        var start = 0, end = 0
        for item in self {
            if (end - start) >= k {
                start += 1
            }
            elements.append(item)
            end += 1
        }
        return Array(elements[0..<start])
    }
    
    func dropExt(while predicate: (Self.Element) throws -> Bool) rethrows -> [Self.Element] {
        var elements = [Element](), alreadyDropped = false
        for item in self {
            if try !predicate(item) || alreadyDropped {
                if alreadyDropped == false {
                    alreadyDropped = true
                }
                elements.append(item)
            }
        }
        return elements
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func filterExt(_ predicate: (Self.Element) throws -> Bool) rethrows -> [Self.Element] {
        var elements = [Element]()
        for item in self {
            if try predicate(item) {
                elements.append(item)
            }
        }
        return elements
    }
}
//MARK: - Transforming a sequence
extension Sequence {
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(1)
     */
    func mapExt<T>(_ transform: (Self.Element) throws -> T) rethrows -> [T] {
        var elements = [T]()
        for item in self {
            elements.append(try transform(item))
        }
        return elements
    }
    
    /*
     Time Complexity: O(n), where n is the length of the sequence.
     Space Complexity: O(K), where K is the length of the result
     */
    func compactMap<ElementOfResult>(_ transform: (Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        var result = [ElementOfResult]()
        for item in self {
            if let transformedElement = try transform(item) {
                result.append(transformedElement)
            }
        }
        return result
    }
    
    func flatMapExt<SegmentOfResult: Sequence>(_ transform: (Self.Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] {
        var result = [SegmentOfResult.Element]()
        for item in self {
            let segment = try transform(item)
            for segmentItem in segment {
                result.append(segmentItem)
            }
        }
        return result
    }
    
    func reduceExt<Result>(_ initialResult: Result,_ nextPartialResult: (Result, Self.Element) throws -> Result) rethrows -> Result {
        var result = initialResult
        for item in self {
            result = try nextPartialResult(result, item)
        }
        return result
    }
    
    func reduceIntoExt<Result>(into initialResult: Result, _ updateAccumulatingResult: (_ partialResult: inout Result, Self.Element) throws -> ()) rethrows -> Result {
        var result = initialResult
        for item in self {
            try updateAccumulatingResult(&result, item)
        }
        return result
    }
    
    func scan<Result>(initial: Result, nextPartialResult: (Result, Self.Element) -> Result) -> [Result] {
        var result = [initial]
        for element in self {
            result.append(nextPartialResult(result.last!, element))
        }
        return result
    }
}
//MARK: - Iterating Over a Sequence's Elements
extension Sequence {
    func forEach(_ body: (Self.Element) throws -> Void) rethrows {
        for item in self {
            try body(item)
        }
    }
    
//    func enumerated() -> EnumeratedSequence<Self> {
//        EnumeratedSequence(_base: self)
//    }
}

//MARK: - Sorting Elements
extension Sequence where Self.Element: Comparable {
    func sortedExt() -> [Self.Element] {
        var elements = [Element]()
        for item in self {
            elements.append(item)
        }
        return MergeSort().mergeSort(elements)
    }
    
    /*
     Time Complexity: O(n^2), where n is the length of the sequence. n^2, as for each item we appennd at first which is again a O(n)
     Space Complexity: O(n)
     */
    func reversedExt() -> [Self.Element] {
        var elements = [Element]()
        for item in self {
            elements.append(item)
        }
        
        var result = [Self.Element]()
        while let lastItem = elements.popLast() {
            result.append(lastItem)
        }
        return result
    }
}

//MARK: - Reordering a Sequence’s Elements
extension Sequence  {
    func shuffled() -> [Self.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

//MARK: - Comparing Sequences
extension Sequence {
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence: Sequence, OtherSequence.Element == Self.Element {
        //TODO
        true
    }
}
extension Sequence where Element == String {
    func joinedExt(separator: String = "") -> String {
        var result = ""
        for item in self {
            result.append(item)
            result.append(separator)
        }
        return result
    }
}
