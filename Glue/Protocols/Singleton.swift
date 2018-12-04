//
//  Singleton.swift
//  Glue
//
//  Created by 김인중 on 04/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

protocol Singleton {
    associatedtype T
    static var sharedInstance: T! { get }
    static func setup() -> T
}
