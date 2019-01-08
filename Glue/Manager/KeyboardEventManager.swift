//
//  KeyboardEventManager.swift
//  Glue
//
//  Created by 김인중 on 04/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa
import MASShortcut

class KeyboardEventManager {
    init() {
        // keyboard event handling
        let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let accessibilityEnabled = AXIsProcessTrustedWithOptions(options)
        
        if accessibilityEnabled == false {
            NSApplication.shared.terminate(self)
        }
        registerShortcut()
    }
    
    func registerShortcut() {
        // TODO: 코드 리펙토링 필요.
        guard let configManager = GlueConfigurationManager.sharedInstance else {
                return
        }
        let flags = configManager.getConfigOption()
        let config = configManager.config
        
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.up.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachFillTop()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.down.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachFillBottom()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.right.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachFillRight()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.left.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachFillLeft()
        })
        
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.rightUp.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachRightTop()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.leftUp.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachLeftTop()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.rightDown.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachRightBottom()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.leftDown.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                AppWindow.frontmost()?.attachLeftBottom()
        })
        
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.moveUp.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByUp)
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.moveDown.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByDown)
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.moveRight.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByRight)
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: config.moveLeft.getUInt(),
                                                               modifierFlags: flags.rawValue), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByLeft)
        })
    }
    
    func updateRegisterShortcut() {
        MASShortcutMonitor.shared()?.unregisterAllShortcuts()
        registerShortcut()
    }
}

