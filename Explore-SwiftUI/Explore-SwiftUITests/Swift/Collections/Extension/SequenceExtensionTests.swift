//
//  SequenceExtensionTests.swift
//  Explore-SwiftUITests
//
//  Created by Abhilash Palem on 26/11/22.
//

import XCTest
@testable import Explore_SwiftUI

class SequenceExtensionTests: XCTestCase {

    func testContains() {
        let arr = Array(10..<30)
        XCTAssertTrue(arr.containsExt(21))
        XCTAssertFalse(arr.containsExt(31))
        XCTAssertTrue(arr.containsExt(10))
        XCTAssertFalse(arr.containsExt(30))
    }
    
    func testContainsWhere() {
        let arr = Array(10..<30)
        XCTAssertTrue(arr.containsExt(where: { $0 == 21 }))
        XCTAssertFalse(arr.containsExt(where: { $0 == 31 }))
        XCTAssertTrue(arr.containsExt(where: { $0 == 10 }))
        XCTAssertFalse(arr.containsExt(where: { $0 == 30 }))
    }

    func testAllSatisfyExt() {
        let arr = Array(10..<30)
        XCTAssertTrue(arr.allSatisfyExt{$0 > 9})
        XCTAssertFalse(arr.allSatisfyExt{$0 > 10})
    }
    
    func testMinExt() {
        let arr = Array(10..<30)
        XCTAssertEqual(10, arr.minExt())
        XCTAssertEqual(10, arr.min())
    }
    
    func testMinExtPredicate() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.minExt(by: <), 12)
        XCTAssertEqual(arr.min(by: <), 12)
    }
    
    func testMaxExt() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(674, arr.maxExt())
        XCTAssertEqual(674, arr.max())
    }

    func testMaxExtPredicate() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.maxExt(by: {$0 < $1}), 674)
        XCTAssertEqual(arr.max(by: {$0 < $1}), 674)
    }
    
    func testPrefixExt() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        for i in arr.prefixExt(3) {
            print(i)
        }
    }
    
    func testPrefixExtPredicate() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.prefixExt(where: {$0 < 500}), [112, 34, 53, 24])
    }
    
    func testSuffixExt() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.suffixExt(2), [45, 12])
    }
    
    func testDropWhileExt() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.dropExt(while: {$0 < 500}), [674, 45, 12])
    }
    
    func testFlatMapext() {
        let numbers = [1, 2, 3, 4]
        XCTAssertEqual(numbers.flatMapExt { Array(repeating: $0, count: $0) }, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4])
        XCTAssertEqual(numbers.flatMap { Array(repeating: $0, count: $0) }, [1, 2, 2, 3, 3, 3, 4, 4, 4, 4])
    }
    
    func testreduceExt() {
        let numbers = [1, 2, 3, 4]
        let numberSumExt = numbers.reduceExt(0, { x, y in
            x + y
        })
        let numberSum = numbers.reduce(0, { x, y in
            x + y
        })
        XCTAssertEqual(numberSum, numberSumExt)
        XCTAssertEqual(numberSum, 10)
    }
    
    func testreduceIntoExt() {
        let numbers = [1, 2, 3, 4]
        let numberSumExt = numbers.reduceIntoExt(into: 0) { partialResult, item in
            partialResult += item
        }
        let numberSum = numbers.reduce(into: 0) { partialResult, item in
            partialResult += item
        }
        XCTAssertEqual(numberSum, numberSumExt)
        XCTAssertEqual(numberSum, 10)
    }
    
    func testSortedExt() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.sortedExt(), [112, 34, 53, 24, 674, 45, 12].sorted())
    }
    
    func testReversedExt() {
        let arr = [112, 34, 53, 24, 674, 45, 12]
        XCTAssertEqual(arr.reversed(), arr.reversedExt())
    }
}
