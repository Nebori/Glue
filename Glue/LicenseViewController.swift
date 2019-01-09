//
//  LicenseViewController.swift
//  Glue
//
//  Created by 김인중 on 04/01/2019.
//  Copyright © 2019 nebori92. All rights reserved.
//

import Cocoa

class LicenseViewController: NSViewController, NSTextFieldDelegate {
    
    // MARK: - UI Componenets Outlet
    @IBOutlet weak var glueLicenseLabel: NSTextField!
    @IBOutlet weak var contactLabel: NSTextField!
    // Third party
    @IBOutlet weak var thirdPartyLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let contactString = "Contact".localized
        glueLicenseLabel.stringValue = "GlueLicense".localized
        contactLabel.attributedStringValue = contactString.addLink(font: NSFont.systemFont(ofSize: 14),
                                                                   wantLinkString: "nebori92@gmail.com",
                                                                   linkString: "mailto:nebori92@gmail.com")
        contactLabel.isSelectable = true
        contactLabel.allowsEditingTextAttributes = true
        thirdPartyLabel.stringValue = createThirdPartyLicenseString()
    }
    
    private func createThirdPartyLicenseString() -> String {
        return """
        mado-size
        https://github.com/shadanan/mado-size
        Copyright © 2016 Shad Sharma. All rights reserved.
        MIT License
        ----
        MASShortcut
        https://github.com/shpakovski/MASShortcut
        Copyright © 2012-2013, Vadim Shpakovski. All rights reserved.
        BSD 2-Clause License
        """
    }
    
}
