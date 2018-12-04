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
        guard let config = GlueConfigurationManager.sharedInstance else {
            return
        }
        let (flags, numFlags) = config.getConfigOption()
        
        // TODO: 구조체로 변경 예정
        let (up, down, right, left) = (126, 125, 124, 123)
        
        switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
        case flags where event.keyCode == up,
             numFlags where event.keyCode == up:
            print("up")
        case flags where event.keyCode == down,
             numFlags where event.keyCode == down:
            print("down")
        case flags where event.keyCode == right,
             numFlags where event.keyCode == right:
            print("right")
        case flags where event.keyCode == left,
             numFlags where event.keyCode == left:
            print("left")
        default:
            break
        }
    }
}
