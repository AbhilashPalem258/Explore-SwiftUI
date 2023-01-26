//
//  BidirectionalCollectionTests.swift
//  Explore-SwiftUITests
//
//  Created by Abhilash Palem on 05/12/22.
//

import XCTest
@testable import Explore_SwiftUI

class BidirectionalCollectionTests: XCTestCase {

    func testLastIndex() {
        let arr = [100, 200, 300, 400, 200, 500, 600]
        XCTAssertEqual(arr.lastIndexExt(of: 200), arr.lastIndex(of: 200))
    }
    
}
