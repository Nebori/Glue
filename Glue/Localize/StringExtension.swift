//
//  StringExtension.swift
//  Glue
//
//  Created by 김인중 on 04/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
