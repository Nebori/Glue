//
//  FrameStore.swift
//  Glue
//
//  Created by 김인중 on 17/01/2018.
//  Copyright © 2018 Injungkim. All rights reserved.
//

import Cocoa

/**
 Indicates the status of the frame.
 */
enum framePosition {
    case firstTime
    case up
    case down
    case right
    case left
    case rightUp
    case rightDown
    case leftUp
    case leftDown
    case sideByUp
    case sideByDown
    case sideByRight
    case sideByLeft
}

/**
 The class that has the status of the window that control
 */
class FrameStore {
    /// Title
    var appTitle: String?
    
    /// Position information for window
    var rect: CGRect?
    
    /// Position information for before
    var beforeRect: CGRect?
    
    /// Position information for inital
    var firstRect: CGRect?
    
    /// Currently position value
    var position: framePosition?
    
    init() {
        let app: AppWindow? = AppWindow.frontmost()
        self.changePosition(changePosition: framePosition.firstTime)
        self.firstRect = app?.globalFrame
    }
    
    /**
     Change position properties
     
     - returns: void
     
     - Parameters:
     - changePosition: position of FrameStore
     */
    func changePosition(changePosition: framePosition!) {
        guard let position = changePosition else {
            return
        }
        var finishPosition: framePosition = position
        let app: AppWindow? = AppWindow.frontmost()
        if app == nil {
            return
        }
        switch position {
        case .firstTime:
            break
        case .up:
            app?.maximize()
        case .down:
            app?.frame = self.firstRect
        case .right:
            app?.attachFillRight()
        case .left:
            app?.attachFillLeft()
        case .rightUp:
            app?.attachRightTop()
        case .leftUp:
            app?.attachLeftTop()
        case .rightDown:
            app?.attachRightBottom()
        case .leftDown:
            app?.attachLeftBottom()
        case .sideByUp:
            if app?.sideBySide(direction: changePosition) == false {
                finishPosition = .down
            } else {
                finishPosition = self.position!
            }
        case .sideByDown:
            if app?.sideBySide(direction: changePosition) == false {
                finishPosition = .up
            } else {
                finishPosition = self.position!
            }
        case .sideByRight:
            if app?.sideBySide(direction: changePosition) == false {
                finishPosition = .left
            } else {
                finishPosition = self.position!
            }
        case .sideByLeft:
            if app?.sideBySide(direction: changePosition) == false {
                finishPosition = .right
            } else {
                finishPosition = self.position!
            }
        }
        self.rect = app?.globalFrame
        self.beforeRect = app?.globalFrame
        self.appTitle = app?.appTitle
        self.position = finishPosition
    }
}
