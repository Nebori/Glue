//
//  LicenseViewController.swift
//  Glue
//
//  Created by 김인중 on 04/01/2019.
//  Copyright © 2019 nebori92. All rights reserved.
//

import Cocoa

class LicenseViewController: NSViewController {
    
    // MARK: - UI Componenets Outlet
    @IBOutlet weak var glueLicenseLabel: NSTextField!
    @IBOutlet weak var contactLabel: NSTextField!
    // Third party
    @IBOutlet weak var thirdPartyLabel: NSTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        glueLicenseLabel.stringValue = "GlueLicense".localized
        contactLabel.stringValue = "Contact".localized
        thirdPartyLabel.stringValue = createThirdPartyLicenseString()
    }
    
    private func createThirdPartyLicenseString() -> String {
        return """
        mado-size
        https://github.com/shadanan/mado-size
        Copyright © 2016 Shad Sharma. All rights reserved.
        MIT License
        """
    }
    
}
