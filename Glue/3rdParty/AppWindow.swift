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
                neboriGlobalFrame(frame: frame)
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
            let y: CGFloat! = visibleFrame.origin.y + (visibleFrame.size.height / 2)
            let width: CGFloat! = visibleFrame.size.width
            let height: CGFloat! = visibleFrame.size.height/2
            
            if (mistakeEqual(x, current.origin.x),
                mistakeEqual(y, current.origin.y),
                mistakeEqual(width, current.size.width),
                mistakeEqual(height, current.size.height)) == (true, true, true, true) {
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
            
            if (mistakeEqual(x, current.origin.x),
                mistakeEqual(y, current.origin.y),
                mistakeEqual(width, current.size.width),
                mistakeEqual(height, current.size.height)) == (true, true, true, true) {
                let _ = sideBySide(direction: .sideByDown)
                return
            }
            
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachRightTop() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x + visibleFrame.width/2
            let y: CGFloat! = visibleFrame.origin.y + (visibleFrame.size.height / 2)
            let width: CGFloat! = visibleFrame.size.width/2
            let height: CGFloat! = visibleFrame.size.height/2
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachLeftTop() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.origin.y + (visibleFrame.size.height / 2)
            let width: CGFloat! = visibleFrame.size.width/2
            let height: CGFloat! = visibleFrame.size.height/2
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachRightBottom() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x + visibleFrame.width/2
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.width/2
            let height: CGFloat! = visibleFrame.height/2
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func attachLeftBottom() {
        if let visibleFrame = screen()?.visibleFrame {
            let x: CGFloat! = visibleFrame.origin.x
            let y: CGFloat! = visibleFrame.origin.y
            let width: CGFloat! = visibleFrame.width/2
            let height: CGFloat! = visibleFrame.height/2
            globalFrame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func sideBySide(direction: framePosition) -> Bool {
        guard let destinationScreen = sideBySideCheck(direction: direction) else {
            return true
        }
        
        if destinationScreen == self.screen() {
            return true
        }
        
        var changeRect: CGRect = CGRect()
        
        switch direction {
        case .sideByUp:
            changeRect = CGRect(x: destinationScreen.visibleFrame.origin.x, y: destinationScreen.visibleFrame.origin.y,
                                width: destinationScreen.visibleFrame.width, height: destinationScreen.visibleFrame.height/2)
        case .sideByDown:
            changeRect = CGRect(x: destinationScreen.visibleFrame.origin.x, y: destinationScreen.visibleFrame.origin.y + destinationScreen.visibleFrame.height/2,
                                width: destinationScreen.visibleFrame.width, height: destinationScreen.visibleFrame.height/2)
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
    
    func sideBySideDirectly(direction: framePosition) -> Bool {
        guard let destinationScreen = sideBySideCheck(direction: direction),
            let screen = screen(),
            let current = globalFrame else {
                return true
        }
        
        if destinationScreen == self.screen() {
            return true
        }

        let visibleFrame = screen.visibleFrame
        let originXPer = current.origin.x < 0 ? 1 - current.origin.x.magnitude / visibleFrame.size.width : (current.origin.x.magnitude - visibleFrame.origin.x.magnitude) / visibleFrame.size.width
        let originYPer = current.origin.y < 0 ? 1 - current.origin.y.magnitude / visibleFrame.size.height : (current.origin.y.magnitude - visibleFrame.origin.y.magnitude) / visibleFrame.size.height
        let sizeXPer = current.size.width / visibleFrame.size.width
        let sizeYPer = current.size.height / visibleFrame.size.height
        
        let roundXPer = roundedWithLength(Double(originXPer) , length: 2)
        let roundYPer = roundedWithLength(Double(originYPer) , length: 2)
        let roundsizeXPer = roundedWithLength(Double(sizeXPer) , length: 2)
        let roundsizeYPer = roundedWithLength(Double(sizeYPer) , length: 2)
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0
        
        let frame = destinationScreen.visibleFrame
        switch direction {
        case .sideByUp:
            x = frame.size.width * roundXPer + frame.origin.x
            y = frame.size.height * roundYPer + frame.origin.y
            width = frame.size.width * roundsizeXPer
            height = frame.size.height * roundsizeYPer
        case .sideByDown:
            x = frame.size.width * roundXPer + frame.origin.x
            y = frame.size.height * roundYPer - frame.origin.y.magnitude
            width = frame.size.width * roundsizeXPer
            height = frame.size.height * roundsizeYPer
        case .sideByRight:
            x = frame.size.width * roundXPer + frame.origin.x
            y = frame.size.height * roundYPer
            width = frame.size.width * roundsizeXPer
            height = frame.size.height * roundsizeYPer
        case .sideByLeft:
            x = frame.size.width * roundXPer - frame.origin.x.magnitude
            y = frame.size.height * roundYPer + frame.origin.y.magnitude
            width = frame.size.width * roundsizeXPer
            height = frame.size.height * roundsizeYPer
        default:
            return false
        }
        
        let rect = CGRect(x: x, y: y, width: width, height: height)
        if isScreenValidatePosition(position: rect) {
            globalFrame = rect
        }
        return true
    }
    
    private func sideBySideCheck(direction: framePosition) -> NSScreen? {
        guard let screen = screen(), let screenFrame = globalFrame else {
            return nil
        }
        
        var changeRect: CGRect = CGRect()
        switch direction {
            case .sideByUp:
                changeRect = CGRect(x: screenFrame.origin.x, y: screen.visibleFrame.origin.y + screen.visibleFrame.size.height, width: screenFrame.width, height: screenFrame.height)
            case .sideByDown:
                changeRect = CGRect(x: screenFrame.origin.x, y: screen.visibleFrame.origin.y - screenFrame.height, width: screenFrame.width, height: screenFrame.height)
            case .sideByRight:
                changeRect = CGRect(x: (screen.visibleFrame.origin.x + screen.visibleFrame.width) + screenFrame.width, y: screenFrame.origin.y, width: screenFrame.width, height: screenFrame.height)
            case .sideByLeft:
                changeRect = CGRect(x: screen.visibleFrame.origin.x - screenFrame.width, y: screenFrame.origin.y, width: screenFrame.width, height: screenFrame.height)
            default:
                return nil
        }
        
        guard let destinationScreen = getScreenWithValidatePosition(position: changeRect) else {
            return nil
        }
        
        return destinationScreen
    }
    
    func getScreenWithValidatePosition(position: CGRect) -> NSScreen? {
        let screens = NSScreen.screens
        var result: NSScreen? = nil
        var area: CGFloat = 0
        
        for screen in screens {
            let calculatedRect: CGRect = screenCalculateBeforeChangePosition(currentScreen: screen, position: position)
            let overlap = screen.visibleFrame.intersection(calculatedRect)
            let frame: CGRect = screen.visibleFrame
            #if DEBUG
                print("###############################################################################")
                print("\(position.origin.x), \(position.origin.y), \(position.size.width), \(position.size.height)")
                print("\(frame.origin.x), \(frame.origin.y), \(frame.size.width), \(frame.size.height)")
                print("\(overlap.origin.x), \(overlap.origin.y), \(overlap.size.width), \(overlap.size.height)")
                print("###############################################################################")
            #endif
            let minW = overlap.width == 0 ? 1 : overlap.width
            let minH = overlap.height == 0 ? 1 : overlap.height
            if minW * minH >= area {
                area = minW * minH
                result = screen
            }
        }
        if area == 1 {
            return nil
        }
        return result
    }
    
    func isScreenValidatePosition(position: CGRect) -> Bool {
        guard let screen = getScreenWithValidatePosition(position: position) else {
            return false
        }
        let screenFrame = screen.frame
        let calcWidth = screenFrame.origin.x < 0 ? screenFrame.origin.x.magnitude - position.origin.x.magnitude + position.size.width
            : position.origin.x - screen.frame.origin.x
        let calcHeight = screenFrame.origin.y < 0 ? screenFrame.origin.y.magnitude - position.origin.y.magnitude + position.size.height
            : position.origin.y - screen.frame.origin.y
        if screen.frame.width < calcWidth || screen.frame.height < calcHeight {
            return false
        }
        return true
    }
    
    func screenCalculateBeforeChangePosition(currentScreen: NSScreen, position: CGRect) -> CGRect {
        var originX: CGFloat = 0, originY: CGFloat = 0 , width: CGFloat = 0 , height: CGFloat = 0
        let frame = currentScreen.frame
        
        /*
         // 공통
         position.origin.x
         position.origin.y // 해당 포지션의 0값
        */
        /*
         // 둘 다 음수
         position.origin.x + position.width * -1 // 음수니 최대 좌측값
         position.origin.y + position.height * -1 // 음수니 최대 아래값
         */
        
        /*
         // x값이 음수
         position.origin.x + position.width * -1 // 음수니 최대 좌측값
         position.origin.y + position.height // 해당 포지션의 최대값
         */
        
        /*
         // y값이 음수
         position.origin.x + position.width // 해당 포지션의 최대값
         position.origin.y + position.height * -1 // 음수니 최대 아래값
         */
        
        /*
         // 둘 다 양수
         position.origin.x + position.width
         position.origin.y + position.height // 해당 포지션의 최대값
         */
        
        originX = position.origin.x
        originY = position.origin.y
        width = position.width > frame.width ? frame.width : position.width
        height = position.height > frame.height ? frame.height : position.height
        
        return CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    func roundedWithLength(_ value: Double, length: Int) -> CGFloat {
        let powDecimal = pow(10, Double(length))
        let prepare = round(value * powDecimal)
        return CGFloat(prepare / powDecimal)
    }
    
    func mistakeEqual(_ first: CGFloat, _ second: CGFloat) -> Bool {
        let mistakeMargin: CGFloat = 2
        if first.distance(to: second).magnitude > mistakeMargin {
            return false
        }
        return true
    }
    
    func neboriGlobalFrame(frame: CGRect) {
        /*
         a. size -> origin (Size first, origin second)
         b. origin -> size (Origin first, size second)
         
         1. Monitor size < frame size (b)
         2. Small monitor -> Big monitor (b)
         3. Big monitor -> Small monitor (a)
         4. Same monitor (b)
         */
        enum MoveType {
            case sizeFirst
            case originFirst
        }
        
        var type: MoveType = .sizeFirst
        if let screen = screen(),
            let destinationScreen = getScreenWithValidatePosition(position: frame) {
            
            if screen.frame.size.width <= frame.size.width || screen.frame.size.height <= frame.size.height {
                // 1. Monitor size < frame size (b)
                type = .originFirst
            }
            if screen.frame.size.width < destinationScreen.frame.size.width || screen.frame.size.height < destinationScreen.frame.size.height {
                // 2. Small monitor -> Big monitor (b)
                type = .originFirst
            } else if screen.frame.size.width > destinationScreen.frame.size.width || screen.frame.size.height > destinationScreen.frame.size.height {
                // 3. Big monitor -> Small monitor (a)
                type = .sizeFirst
            } else if screen.frame == destinationScreen.frame {
                // 4. Same monitor (b)
                type = .originFirst
            }
            switch type {
            case .sizeFirst:
                size = frame.size
                appOrigin = CGPoint(x: frame.origin.x, y: primaryScreenHeight - frame.size.height - frame.origin.y)
            case .originFirst:
                appOrigin = CGPoint(x: frame.origin.x, y: primaryScreenHeight - frame.size.height - frame.origin.y)
                size = frame.size
            }
        }
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

