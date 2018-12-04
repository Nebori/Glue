//
//  GlueConfiguration.swift
//  Glue
//
//  Created by 김인중 on 03/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

struct GlueConfig: Codable {
    var control: Bool
    var option: Bool
    var command: Bool
    init() {
        control = true
        option = true
        command = true
    }
}

class GlueConfiguration: CodableReadWritable {
    var path: URL
    var config: GlueConfig
    
    init() {
        let searchDirectoryArray = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        path = URL(string: "file://" + searchDirectoryArray[0])!
        path.appendPathComponent(Bundle.main.bundleIdentifier!)
        path.appendPathComponent("glueConfig.plist")
        config = GlueConfig.init()
        do {
            if let codableObj = try read(type: GlueConfig.self) {
                config = codableObj
            }
        } catch {
            
        }
    }
}
