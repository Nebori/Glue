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
        // window risize handling
        let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let accessibilityEnabled = AXIsProcessTrustedWithOptions(options)
        
        if accessibilityEnabled == false {
            // 권한 설정을 부탁하는 내용이 추가 되어야 함
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
        MASShortcutMonitor.shared().register(MASShortcut.init(keyCode: Int(config.up.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue: flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachFillTop()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.down.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachFillBottom()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.right.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachFillRight()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.left.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachFillLeft()
        })

        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.rightUp.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachRightTop()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.leftUp.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachLeftTop()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.rightDown.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachRightBottom()
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.leftDown.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                AppWindow.frontmost()?.attachLeftBottom()
        })

        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.moveUp.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByUp)
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.moveDown.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByDown)
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.moveRight.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByRight)
        })
        MASShortcutMonitor.shared()?.register(MASShortcut.init(keyCode: Int(config.moveLeft.getUInt()),
                                                               modifierFlags: NSEvent.ModifierFlags(rawValue:flags.rawValue)), withAction: {
                                                                _ = AppWindow.frontmost()?.sideBySideDirectly(direction: .sideByLeft)
    }
    
    func updateRegisterShortcut() {
        MASShortcutMonitor.shared()?.unregisterAllShortcuts()
        registerShortcut()
    }
}

