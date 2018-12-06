//
//  GlueConfiguration.swift
//  Glue
//
//  Created by 김인중 on 03/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

enum GlueConfigCategory {
    case control
    case option
    case command
}

struct GlueConfig: Codable {
    // Shortcut
    var control: Bool
    var option: Bool
    var command: Bool
    // Direction
    var up: UInt16
    var down: UInt16
    var right: UInt16
    var left: UInt16
    // Quarter
    var rightUp: UInt16
    var leftUp: UInt16
    var rightDown: UInt16
    var leftDown: UInt16
    
    init() {
        control = true
        option = true
        command = true
        
        up = 126
        down = 125
        right = 124
        left = 123
        
        // o p
        // l ;
        rightUp = 35
        leftUp = 31
        rightDown = 41
        leftDown = 37
    }
}
