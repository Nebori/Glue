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
    
    func addLink(font: NSFont, wantLinkString: String, linkString: String) -> NSMutableAttributedString {
        let linkAttributeString = NSMutableAttributedString(string: self, attributes: [.font: font])
        linkAttributeString.setAlignment(.center, range: NSRange(location: 0, length: linkAttributeString.length))
        linkAttributeString.addAttribute(.link, value: linkString, range: (self as NSString).range(of: wantLinkString))
        return linkAttributeString
    }
}
