//
//  BagIndex.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/11/22.
//

import Foundation

struct BagIndex<Element: Hashable> {
    let index: DictionaryIndex<Element, Int>
    
    init(_ dictionaryIndex: DictionaryIndex<Element, Int>) {
        self.index = dictionaryIndex
    }
}
extension BagIndex: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.index < rhs.index
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.index == rhs.index
    }
}
