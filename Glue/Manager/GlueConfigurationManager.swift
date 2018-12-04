//
//  GlueConfigurationManager.swift
//  Glue
//
//  Created by 김인중 on 04/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

private var _glueConfigurationManager: GlueConfigurationManager!
class GlueConfigurationManager: CodableReadWritable, Singleton {
    var path: URL
    var config: GlueConfig
    
    class var sharedInstance: GlueConfigurationManager! {
        if _glueConfigurationManager == nil {
            _glueConfigurationManager = GlueConfigurationManager()
        }
        return _glueConfigurationManager
    }
    
    static func setup() -> GlueConfigurationManager {
        if _glueConfigurationManager == nil {
            _glueConfigurationManager = GlueConfigurationManager()
        }
        return _glueConfigurationManager
    }
    
    private init() {
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
            let directoryPath = path.deletingLastPathComponent()
            do {
                try FileManager.default.createDirectory(at: directoryPath,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
            } catch {
                
            }
            save(codableObj: config)
        }
    }
    
    func getConfigOption() -> (NSEvent.ModifierFlags, NSEvent.ModifierFlags) {
        var flags: NSEvent.ModifierFlags = NSEvent.ModifierFlags()
        var numFlags: NSEvent.ModifierFlags = NSEvent.ModifierFlags()
        if config.control {
            flags.insert(.control)
            numFlags.insert(.control)
        }
        if config.option {
            flags.insert(.option)
            numFlags.insert(.option)
        }
        if config.command {
            flags.insert(.command)
            numFlags.insert(.command)
        }
        numFlags.insert(.numericPad)
        numFlags.insert(.function)
        return (flags, numFlags)
    }
    
    func getUsage() -> String {
        var usageStr = String()
        if config.control {
            usageStr += "⌃ "
        }
        if config.option {
            usageStr += "⌥ "
        }
        if config.command {
            usageStr += "⌘ "
        }
        return usageStr
    }
    
    func changeConfig(_ category: GlueConfigCategory) {
        switch category {
        case .control:
            config.control = !config.control
        case .option:
            config.option = !config.option
        case .command:
            config.command = !config.command
        }
    }
}
