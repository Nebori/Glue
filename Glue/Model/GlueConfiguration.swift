//
//  GlueConfiguration.swift
//  Glue
//
//  Created by 김인중 on 03/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

enum GlueConfigCategory {
    // Shortcut
    case control
    case option
    case command
}

enum GlueConfigShortcut {
    // Direction
    case up
    case down
    case right
    case left
    // Quarter
    case rightUp
    case leftUp
    case rightDown
    case leftDown
    // Move Screen
    case moveUp
    case moveDown
    case moveRight
    case moveLeft
}

struct GlueConfig: Codable {
    // Shortcut
    var control: Bool
    var option: Bool
    var command: Bool
    // Direction
    var up: KeyboardKey
    var down: KeyboardKey
    var right: KeyboardKey
    var left: KeyboardKey
    // Quarter
    var rightUp: KeyboardKey
    var leftUp: KeyboardKey
    var rightDown: KeyboardKey
    var leftDown: KeyboardKey
    // Move Screen
    var moveUp: KeyboardKey
    var moveDown: KeyboardKey
    var moveRight: KeyboardKey
    var moveLeft: KeyboardKey
    
    init() {
        control = true
        option = true
        command = true
        
        up = KeyboardKey.init(.up)
        down = KeyboardKey.init(.down)
        right = KeyboardKey.init(.right)
        left = KeyboardKey.init(.left)
        
        rightUp = KeyboardKey.init(.o)
        leftUp = KeyboardKey.init(.p)
        rightDown = KeyboardKey.init(.l)
        leftDown = KeyboardKey.init(.semicolon)
        
        moveUp = KeyboardKey.init(.u)
        moveDown = KeyboardKey.init(.j)
        moveRight = KeyboardKey.init(.k)
        moveLeft = KeyboardKey.init(.h)
    }
}
