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
        case flags where event.keyCode == config.up,
             numFlags where event.keyCode == config.up:
            app.attachFillTop()
        case flags where event.keyCode == config.down,
             numFlags where event.keyCode == config.down:
            app.attachFillBottom()
        case flags where event.keyCode == config.right,
             numFlags where event.keyCode == config.right:
            app.attachFillRight()
        case flags where event.keyCode == config.left,
             numFlags where event.keyCode == config.left:
            app.attachFillLeft()
        case flags where event.keyCode == config.rightUp,
             numFlags where event.keyCode == config.rightUp:
            app.attachRightTop()
        case flags where event.keyCode == config.leftUp,
             numFlags where event.keyCode == config.leftUp:
            app.attachLeftTop()
        case flags where event.keyCode == config.rightDown,
             numFlags where event.keyCode == config.rightDown:
            app.attachRightBottom()
        case flags where event.keyCode == config.leftDown,
             numFlags where event.keyCode == config.leftDown:
            app.attachLeftBottom()
        default:
            break
        }
    }
}
