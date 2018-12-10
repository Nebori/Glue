//
//  TestGlueConfigurationManager.swift
//  GlueTests
//
//  Created by 김인중 on 06/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import XCTest
@testable import Glue

class TestGlueConfigurationManager: XCTestCase {
    
    var configManager: GlueConfigurationManager!
    var originConfig: GlueConfig!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        configManager = GlueConfigurationManager.sharedInstance
        originConfig = configManager.config
        let config = GlueConfig()
        // config = true, true, true
        configManager.config = config
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        configManager.config = originConfig
        configManager.save(codableObj: configManager.config)
    }
    
    func testInitialConfigManager() {
        let config = configManager.config
        assert(config.control == true || config.control == false)
        assert(config.option == true || config.option == false)
        assert(config.command == true || config.command == false)
    }
    
    func testGetConfigOption() {
        let expectationOriginFlags: NSEvent.ModifierFlags = [.control, .option, .command]
        let expectationNumFlags: NSEvent.ModifierFlags = [.control, .option, .command, .numericPad, .function]
        
        let (originFlags, numFlags) = configManager.getConfigOption()
     
        assert(expectationOriginFlags == originFlags)
        assert(expectationNumFlags == numFlags)
    }
    
    func testGetUsage() {
        let expectationUsage: String = "⌃ ⌥ ⌘ "
        
        let usage = configManager.getUsage()
        assert(expectationUsage == usage)
    }
    
    func testGetOnCount() {
        let expectationCount: Int = 3
        
        let count = configManager.getOnCount()
        assert(expectationCount == count)
    }
    
    func testChangeConfig() {
        var expectationConfig = GlueConfig()
        expectationConfig.control = false
        expectationConfig.option = false
        expectationConfig.command = false
        
        configManager.changeConfig(.control)
        configManager.changeConfig(.option)
        configManager.changeConfig(.command)
        let config = configManager.config
        
        assert(expectationConfig.control == config.control)
        assert(expectationConfig.option == config.option)
        assert(expectationConfig.command == config.command)
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
