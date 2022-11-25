//
//  FunkyArrayTests.swift
//  Explore-SwiftUITests
//
//  Created by Abhilash Palem on 23/11/22.
//

import XCTest
@testable import Explore_SwiftUI

class FunkyArrayTests: XCTestCase {

    func testFunkyArray() {
        let arr = FunkyArray([1, 2, 3, 4, 5])
        print(arr!["C"])
    }

}
