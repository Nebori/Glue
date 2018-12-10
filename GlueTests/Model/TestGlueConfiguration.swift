//
//  TestGlueConfiguration.swift
//  GlueTests
//
//  Created by 김인중 on 06/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import XCTest
@testable import Glue

class TestGlueConfiguration: XCTestCase {
    
    var config: GlueConfig!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        config = GlueConfig()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialConfig() {
        let (expectationControl, expectationOption, expectationCommand) =
            (true, true, true)
        
        assert(expectationControl == config.control)
        assert(expectationOption == config.option)
        assert(expectationCommand == config.command)
    }
    
    func testChangeConfig() {
        let (expectationControl, expectationOption, expectationCommand) =
            (false, false, false)
        
        config.control = false
        config.option = false
        config.command = false
        assert(expectationControl == config.control)
        assert(expectationOption == config.option)
        assert(expectationCommand == config.command)
    }
    
    func testChangeShortcut() {
        // up: 12, q
        // down: 13, w
        // right: 14, e
        let (expectationUp, expectationDown, expectationRight) =
            ("q", "w", "e")
        
        config.up = KeyboardKey.init(12)
        config.down = KeyboardKey.init(13)
        config.right = KeyboardKey.init(14)
        
        assert(expectationUp == config.up.getString())
        assert(expectationDown == config.down.getString())
        assert(expectationRight == config.right.getString())
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
