//
//  TestKeyboardKeys.swift
//  GlueTests
//
//  Created by 김인중 on 07/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import XCTest
@testable import Glue

class TestKeyboardKeys: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialKey() {
        let expectationKeys = KeyboardKeys.q
        let keys = KeyboardKey(.q)
        XCTAssertEqual(expectationKeys, keys.getKey())
    }
    
    func testInitialStringKey() {
        let expectationStr = "q"
        let keys = KeyboardKey(.q)
        XCTAssertEqual(expectationStr, keys.getString())
    }
    
    func testInitalUInt16Key() {
        let expectationUInt16 = 12
        let keys = KeyboardKey(.q)
        XCTAssertEqual(expectationUInt16, Int(keys.getUInt()))
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
