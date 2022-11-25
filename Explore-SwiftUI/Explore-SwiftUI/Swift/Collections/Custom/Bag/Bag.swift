//
//  Bag.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/11/22.
//

import Foundation
/*
 Source:
 https://www.kodeco.com/10286147-building-a-custom-collection-with-protocols-in-swift
 https://itwenty.me/2021/10/understanding-swifts-collection-protocols/
 
 Definition:
 
 Notes:
 - Collectionn vs Sequence: Sequence does not require conforming types to be non-destructive. This means that after iteration, there’s no guarantee that future iterations will start from the beginning. That’s a huge issue if you plan on iterating over your data more than once. To enforce non-destructive iteration, your object needs to conform to the Collection protocol.
 

 */

// Basic Custom Type - Bag
struct Bag<Element: Hashable> {
    fileprivate var contents: [Element: Int] = [:]
    
    var uniqueCount: Int {
        contents.count
    }
    
    var totalCount: Int {
        contents.values.reduce(0, {$0 + $1})
    }
}

extension Bag {
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            if let existingCount = contents[element] {
                contents[element] = existingCount + 1
            } else {
                contents[element] = 1
            }
        }
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Element, value: Int) {
        for (element, count) in sequence {
            if let existingCount = contents[element] {
                contents[element] = existingCount + count
            } else {
                contents[element] = count
            }
        }
    }
}

extension Bag: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
extension Bag: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Element, Int)...) {
        self.init(elements)
    }
}

extension Bag {
    mutating func add(_ element: Element) {
        if let existingCount = contents[element] {
            contents[element] = existingCount + 1
        } else {
            contents[element] = 1
        }
    }
    
    mutating func remove(_ element: Element, occurences: Int = 1) throws {
        guard let existingCount = contents[element], existingCount >= occurences else {
            throw "Invalid deletion count"
        }
        
        if existingCount == occurences {
            contents.removeValue(forKey: element)
        } else {
            contents[element] = existingCount - occurences
        }
    }
}

extension Bag: CustomStringConvertible {
    var description: String {
        contents.description
    }
}

//MARK: - Sequence Conformance
/*
 Currently, you're relying on Dictionary to handle the heavy lifting for you. That's fine because it makes creating powerful collections of your own easy. The problem is that it creates strange and confusing situations for Bag users. For example, it's not intuitive that Bag returns an iterator of type DictionaryIterator.
 */
//extension Bag: Sequence {
//
//    typealias Iterator = Dictionary<Element, Int>.Iterator
//
//    func makeIterator() -> Iterator {
//        contents.makeIterator()
//    }
//}

extension Bag: Sequence {
    typealias Iterator = AnyIterator<(element: Element, count: Int)>
    
    func makeIterator() -> Iterator {
        var iterator = contents.makeIterator()
        return AnyIterator {
            iterator.next()
        }
    }
}

//MARK: - Collection Conformance
//extension Bag: Collection {
//    typealias Index = DictionaryIndex<Element, Int>
//
//    var startIndex: Index {
//        contents.startIndex
//    }
//
//    var endIndex: Index {
//        contents.endIndex
//    }
//
//    subscript(position: Index) -> (element: Element, count: Int) {
//        let element = contents[position]
//        return (element: element.key, count: element.value)
//    }
//
//    func index(after i: Index) -> Index {
//        contents.index(after: i)
//    }
//}
extension Bag: Collection {
    typealias Index = BagIndex<Element>
    
    var startIndex: Index {
        BagIndex(contents.startIndex)
    }
    
    var endIndex: Index {
        BagIndex(contents.endIndex)
    }
    
    func index(after i: BagIndex<Element>) -> BagIndex<Element> {
        BagIndex(contents.index(after: i.index))
    }
    
    subscript(position: BagIndex<Element>) -> (element: Element, count: Int) {
        let element = contents[position.index]
        return (element: element.key, count: element.value)
    }
}
