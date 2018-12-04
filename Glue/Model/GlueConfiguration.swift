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
    var control: Bool
    var option: Bool
    var command: Bool
    init() {
        control = true
        option = true
        command = true
    }
}
