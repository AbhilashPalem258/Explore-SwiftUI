//
//  FunkyArray.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/11/22.
//

import Foundation

//https://itwenty.me/2021/10/understanding-swifts-collection-protocols/
struct FunkyArray<Item> {
    private var internalArray: [Item] = []
    private let start: Character = "A"
    private let end: Character = "["
    
    init?<S: Collection>(_ elements: S) where S.Element == Item {
        let maxElements = charToInt(end) - charToInt(start)
        guard elements.count < maxElements else {
            return nil
        }
        for element in elements {
            internalArray.append(element)
        }
    }
    
    func charToInt(_ char: Character) -> Int {
        Int(char.asciiValue! - start.asciiValue!)
    }
    
    func intToChar(_ val: Int) -> Character {
        Character(UnicodeScalar(start.asciiValue! + UInt8(val)))
    }
}
extension FunkyArray: Collection {
    var startIndex: Character {
        start
    }
    
    var endIndex: Character {
        end
    }
    
//    subscript(position: Character) -> Item {
//        let intVal = charToInt(position)
//        return internalArray[intVal]
//    }
    
    func index(after i: Character) -> Character {
        intToChar(charToInt(i) + 1)
    }
}
extension FunkyArray: BidirectionalCollection {
    func index(before i: Character) -> Character {
        intToChar(charToInt(i) - 1)
    }
}
extension FunkyArray: MutableCollection {
    subscript(position: Character) -> Item {
        get {
            let intVal = charToInt(position)
            return internalArray[intVal]
        }
        set {
            let intVal = charToInt(position)
            internalArray[intVal] = newValue
        }
    }
}
extension FunkyArray: RandomAccessCollection {
    
}
extension FunkyArray: RangeReplaceableCollection {
    init() {}
    
    mutating func replaceSubrange<C>(_ subrange: Range<Character>, with newElements: C) where C : Collection, Item == C.Element {
        let firstIndex = charToInt(subrange.lowerBound) - charToInt(startIndex)
        let lastIndex = charToInt(subrange.upperBound) - charToInt(startIndex)
        internalArray.replaceSubrange(firstIndex..<lastIndex, with: newElements)
    }
}
