//
//  KeyboardEventManager.swift
//  Glue
//
//  Created by 김인중 on 04/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

class KeyboardEventManager {
    init() {
        // keyboard event handling
        let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let accessibilityEnabled = AXIsProcessTrustedWithOptions(options)
        
        if accessibilityEnabled == false {
            NSApplication.shared.terminate(self)
        }
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { (event: NSEvent) in
            self.classification(event)
        }
    }
    
    private func classification(_ event: NSEvent) {
        guard let configManager = GlueConfigurationManager.sharedInstance,
            let app = AppWindow.frontmost() else {
            return
        }
        let (flags, numFlags) = configManager.getConfigOption()
        let config = configManager.config
        
        switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
        case flags where event.keyCode == config.up.getUInt16(),
             numFlags where event.keyCode == config.up.getUInt16():
            app.attachFillTop()
        case flags where event.keyCode == config.down.getUInt16(),
             numFlags where event.keyCode == config.down.getUInt16():
            app.attachFillBottom()
        case flags where event.keyCode == config.right.getUInt16(),
             numFlags where event.keyCode == config.right.getUInt16():
            app.attachFillRight()
        case flags where event.keyCode == config.left.getUInt16(),
             numFlags where event.keyCode == config.left.getUInt16():
            app.attachFillLeft()
        case flags where event.keyCode == config.rightUp.getUInt16(),
             numFlags where event.keyCode == config.rightUp.getUInt16():
            app.attachRightTop()
        case flags where event.keyCode == config.leftUp.getUInt16(),
             numFlags where event.keyCode == config.leftUp.getUInt16():
            app.attachLeftTop()
        case flags where event.keyCode == config.rightDown.getUInt16(),
             numFlags where event.keyCode == config.rightDown.getUInt16():
            app.attachRightBottom()
        case flags where event.keyCode == config.leftDown.getUInt16(),
             numFlags where event.keyCode == config.leftDown.getUInt16():
            app.attachLeftBottom()
        default:
            break
        }
    }
}
