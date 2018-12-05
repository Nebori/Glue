//
//  AccessibilityElement.swift
//  MadoSize
//
//  Created by Shad Sharma on 7/3/16.
//  Copyright © 2016 Shad Sharma. All rights reserved.
//  Github: https://github.com/shadanan/mado-size
//

import Cocoa

class AppWindow: CustomStringConvertible {
    let app: NSRunningApplication
    let appElement: AXUIElement
    let windowElement: AXUIElement
    
    static func frontmost() -> AppWindow? {
        guard let frontmostApplication = NSWorkspace.shared.frontmostApplication else {
            return nil
        }
        
        let appElement = AXUIElementCreateApplication(frontmostApplication.processIdentifier)
        
        var result: AnyObject?
        guard AXUIElementCopyAttributeValue(appElement, kAXFocusedWindowAttribute as CFString, &result) == .success else {
            return nil
        }
        
        let windowElement = result as! AXUIElement
        return AppWindow(app: frontmostApplication, appElement: appElement, windowElement: windowElement)
    }
    
    var primaryScreenHeight: CGFloat {
        get {
            let screens = NSScreen.screens
            if screens.count > 0 {
                return screens[0].frame.maxY
            } else {
                return 0
            }
        }
    }
    
    init(app: NSRunningApplication, appElement: AXUIElement, windowElement: AXUIElement) {
        self.app = app
        self.appElement = appElement
        self.windowElement = windowElement
    }
    
    fileprivate func value(_ attribute: String, type: AXValueType) -> AXValue? {
        guard CFGetTypeID(windowElement) == AXUIElementGetTypeID() else {
            return nil
        }
        
        var result: AnyObject?
        guard AXUIElementCopyAttributeValue(windowElement, attribute as CFString, &result) == .success else {
            return nil
        }
        
        let value = result as! AXValue
        guard AXValueGetType(value) == type else {
            return nil
        }
        
        return value
    }
    
    fileprivate func setValue(_ value: AXValue, attribute: String) {
        let status = AXUIElementSetAttributeValue(windowElement, attribute as CFString, value)
        
        if status != .success {
            print("Failed to set \(attribute)=\(value)")
        }
    }
    
    fileprivate var appOrigin: CGPoint? {
        get {
            guard let positionValue = value(kAXPositionAttribute, type: .cgPoint) else {
                return nil
            }
            
            var position = CGPoint()
            AXValueGetValue(positionValue, .cgPoint, &position)
            
            return position
        }
        
        set {
            var origin = newValue
            guard let positionRef = AXValueCreate(.cgPoint, &origin) else {
                print("Failed to create positionRef")
                return
            }
            
            setValue(positionRef, attribute: kAXPositionAttribute)
        }
    }
    
    var origin: CGPoint? {
        get {
            guard let appOrigin = appOrigin, let size = size else {
                return nil
            }
            
            return CGPoint(x: appOrigin.x, y: primaryScreenHeight - size.height - appOrigin.y)
        }
        
        set {
            if let newOrigin = newValue, let size = size {
                appOrigin = CGPoint(x: newOrigin.x, y: primaryScreenHeight - size.height - newOrigin.y)
            }
        }
    }
    
    var size: CGSize? {
        get {
            guard let sizeValue = value(kAXSizeAttribute, type: .cgSize) else {
                return nil
            }
            
            var size = CGSize()
            AXValueGetValue(sizeValue, .cgSize, &size)
            
            return size
        }
        
        set {
            var size = newValue
            guard let sizeRef = AXValueCreate(.cgSize, &size) else {
                print("Failed to create sizeRef")
                return
            }
            
            setValue(sizeRef, attribute: kAXSizeAttribute)
        }
    }
    
    var globalFrame: CGRect? {
        get {
            guard let origin = appOrigin, let size = size else {
                return nil
            }
            
            return CGRect(origin: CGPoint(x: origin.x, y: primaryScreenHeight - size.height - origin.y), size: size)
        }
        
        set {
            if let frame = newValue {
                appOrigin = CGPoint(x: frame.origin.x, y: primaryScreenHeight - frame.size.height - frame.origin.y)
                size = frame.size
            }
        }
    }
    
    var frame: CGRect? {
        get {
            guard let screen = screen(), let globalFrame = globalFrame else {
                return nil
            }
            
            return CGRect(origin: globalFrame.origin - screen.frame.origin, size: globalFrame.size)
        }
        
        set {
            if let screen = screen(), let localFrame = newValue {
                globalFrame = CGRect(origin: localFrame.origin + screen.frame.origin, size: localFrame.size)
            }
        }
    }
    
    
    func center() {
        if let screen = screen(), let size = size {
            let newX = screen.visibleFrame.midX - size.width / 2
            let newY = screen.visibleFrame.midY - size.height / 2
            origin = CGPoint(x: newX, y: newY)
        }
    }
    
    func alignLeft() {
        if let visibleFrame = screen()?.visibleFrame, let origin = origin {
            self.origin = CGPoint(x: visibleFrame.origin.x, y: origin.y)
        }
    }
    
    func alignRight() {
        if let visibleFrame = screen()?.visibleFrame, let origin = origin, let size = size {
            self.origin = CGPoint(x: visibleFrame.width - size.width, y: origin.y)
        }
    }
    
    func alignUp() {
        if let visibleFrame = screen()?.visibleFrame, let origin = origin, let size = size {
            self.origin = CGPoint(x: origin.x, y: visibleFrame.height - size.height)
        }
    }
    
    func alignDown() {
        if let visibleFrame = screen()?.visibleFrame, let origin = origin {
            self.origin = CGPoint(x: origin.x, y: visibleFrame.origin.y)
        }
    }
    
    func maximize() {
        if let visibleFrame = screen()?.visibleFrame {
            globalFrame = visibleFrame
        }
    }
    
    func maximizeVertical() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            globalFrame = CGRect(x: current.origin.x, y: visibleFrame.origin.y,
                                 width: current.width, height: visibleFrame.height)
        }
    }
    
    func maximizeHorizontal() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            globalFrame = CGRect(x: visibleFrame.origin.x, y: current.origin.y,
                                 width: visibleFrame.width, height: current.height)
        }
    }
    
    //  MARK: - nebori92 Start
    
    func halfVertical() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            globalFrame = CGRect(x: current.origin.x, y: current.origin.y,
                                 width: current.width, height: visibleFrame.height/2)
        }
    }
    
    func halfHorizontal() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            globalFrame = CGRect(x: current.origin.x, y: current.origin.y,
                                 width: visibleFrame.width/2, height: current.height)
        }
    }
    
    func attachFillRight() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            let x: CGFloat! = visibleFrame.origin.x + visibleFrame.width/2
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.size.width/2
            let height: CGFloat! = visibleFrame.size.height
            
            if (x, y, width, height) == (current.origin.x,
                                         current.origin.y,
                                         current.size.width,
                                         current.size.height) {
                let _ = sideBySide(direction: .sideByRight)
                return
            }
            
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachFillLeft() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.size.width/2
            let height: CGFloat! = visibleFrame.size.height
            
            if (x, y, width, height) == (current.origin.x,
                                         current.origin.y,
                                         current.size.width,
                                         current.size.height) {
                let _ = sideBySide(direction: .sideByLeft)
                return
            }
            
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachFillTop() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.maxY
            let width: CGFloat! = visibleFrame.size.width
            let height: CGFloat! = visibleFrame.size.height/2
            
            if (x, y, width, height) == (current.origin.x,
                                         current.origin.y,
                                         current.size.width,
                                         current.size.height) {
                let _ = sideBySide(direction: .sideByUp)
                return
            }
            
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachFillBottom() {
        if let visibleFrame = screen()?.visibleFrame, let current = globalFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.size.width
            let height: CGFloat! = visibleFrame.size.height/2
            
            if (x, y, width, height) == (current.origin.x,
                                         current.origin.y,
                                         current.size.width,
                                         current.size.height) {
                let _ = sideBySide(direction: .sideByDown)
                return
            }
            
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachRightTop() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x >= 0 ? visibleFrame.width/2 : visibleFrame.origin.x/2
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.size.width/2
            let height: CGFloat! = visibleFrame.size.height/2
            let frame: CGRect! = CGRect(x: x, y: y, width: width, height: height)
            self.size = frame.size
        }
    }
    
    func attachLeftTop() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.size.width/2
            let height: CGFloat! = visibleFrame.size.height/2
            let frame: CGRect! = CGRect(x: x, y: y, width: width, height: height)
            self.size = frame.size
        }
    }
    
    func attachRightBottom() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x + visibleFrame.width/2
            let y: CGFloat! = visibleFrame.maxY - visibleFrame.height
            let width: CGFloat! = visibleFrame.width/2
            let height: CGFloat! = visibleFrame.height/2
            let frame: CGRect! = CGRect(x: x, y: y, width: width, height: height)
            self.size = frame.size
            self.origin = frame.origin
        }
    }
    
    func attachLeftBottom() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.maxY - visibleFrame.height
            let width: CGFloat! = visibleFrame.width/2
            let height: CGFloat! = visibleFrame.height/2
            let frame: CGRect! = CGRect(x: x, y: y, width: width, height: height)
            self.size = frame.size
            self.origin = frame.origin
        }
    }
    
    func sideBySide(direction: framePosition) -> Bool {
        guard let screen = screen(), let screenFrame = globalFrame else {
            return true
        }
        
        var changeRect: CGRect? = CGRect()
        
        switch direction {
        case .sideByUp:
            changeRect = CGRect(x: screenFrame.origin.x, y: screenFrame.origin.y + screenFrame.height, width: screenFrame.width, height: screenFrame.height)
        case .sideByDown:
            changeRect = CGRect(x: screenFrame.origin.x, y: screen.frame.origin.y - screenFrame.height, width: screenFrame.width, height: screenFrame.height)
        case .sideByRight:
            changeRect = CGRect(x: screen.frame.maxX + screenFrame.width, y: screenFrame.origin.y, width: screenFrame.width, height: screenFrame.height)
        case .sideByLeft:
            changeRect = CGRect(x: screen.frame.minX - screenFrame.width, y: screenFrame.origin.y, width: screenFrame.width, height: screenFrame.height)
        default:
            return true
        }
        
        guard let destinationScreen = getScreenWithValidatePosition(position: changeRect!) else {
            return true
        }
        
        if destinationScreen == self.screen() {
            return true
        }
        
        switch direction {
        case .sideByUp:
            changeRect = CGRect(x: destinationScreen.visibleFrame.origin.x, y: destinationScreen.visibleFrame.origin.y,
                                width: destinationScreen.visibleFrame.width/2, height: destinationScreen.visibleFrame.height/2)
        case .sideByDown:
            changeRect = CGRect(x: destinationScreen.visibleFrame.origin.x, y: destinationScreen.visibleFrame.origin.y,
                                width: destinationScreen.visibleFrame.width/2, height: destinationScreen.visibleFrame.height/2)
        case .sideByRight:
            changeRect = CGRect(x: destinationScreen.visibleFrame.origin.x,
                                y: destinationScreen.visibleFrame.origin.y,
                                width: destinationScreen.visibleFrame.size.width/2,
                                height: destinationScreen.visibleFrame.size.height)
        case .sideByLeft:
            changeRect = CGRect(x: destinationScreen.visibleFrame.origin.x >= 0 ? destinationScreen.visibleFrame.width/2 : destinationScreen.visibleFrame.origin.x/2,
                                y: destinationScreen.visibleFrame.origin.y,
                                width: destinationScreen.visibleFrame.size.width/2,
                                height: destinationScreen.visibleFrame.size.height)
        default:
            return true
        }
        
        globalFrame = changeRect
        
        return false
    }
    
    func getScreenWithValidatePosition(position: CGRect) -> NSScreen? {
        let screens = NSScreen.screens
        var result: NSScreen? = nil
        var area: CGFloat = 0
        
        for screen in screens {
            let calculatedRect: CGRect = screenCalculateBeforeChangePosition(currentScreen: screen, position: position)
            let overlap = screen.frame.intersection(calculatedRect)
            if overlap.width * overlap.height > area {
                area = overlap.width * overlap.height
                result = screen
            }
        }
        
        return result
    }
    
    func screenCalculateBeforeChangePosition(currentScreen: NSScreen, position: CGRect) -> CGRect {
        var originX: CGFloat = 0, originY: CGFloat = 0 , width: CGFloat = 0 , height: CGFloat = 0
        let frame = currentScreen.frame
        
        originX = position.origin.x
        originY = position.origin.y
        width = position.width > frame.width ? frame.width : position.width
        height = position.height > frame.height ? frame.height : position.height
        
        return CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    //  MARK: nebori92 END -
    
    func activateWithOptions(_ options: NSApplication.ActivationOptions) {
        app.activate(options: options)
    }
    
    func screen() -> NSScreen? {
        guard let screenFrame = globalFrame else {
            return nil
        }
        
        let screens = NSScreen.screens
        var result: NSScreen? = nil
        var area: CGFloat = 0
        
        for screen in screens {
            let overlap = screen.frame.intersection(screenFrame)
            if overlap.width * overlap.height > area {
                area = overlap.width * overlap.height
                result = screen
            }
        }
        
        return result
    }
    
    var appTitle: String? {
        get {
            guard CFGetTypeID(appElement) == AXUIElementGetTypeID() else {
                return nil
            }
            
            var result: AnyObject?
            guard AXUIElementCopyAttributeValue(appElement, kAXTitleAttribute as CFString, &result) == .success else {
                return nil
            }
            
            return result as? String
        }
    }
    
    var windowTitle: String? {
        get {
            guard CFGetTypeID(windowElement) == AXUIElementGetTypeID() else {
                return nil
            }
            
            var result: AnyObject?
            guard AXUIElementCopyAttributeValue(windowElement, kAXTitleAttribute as CFString, &result) == .success else {
                return nil
            }
            
            return result as? String
        }
    }
    
    var description: String {
        get {
            return "\(appTitle): \(windowTitle) - Frame: \(frame)"
        }
    }
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

