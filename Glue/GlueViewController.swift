//
//  GlueViewController.swift
//  Glue
//
//  Created by 김인중 on 03/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

class GlueViewController: NSViewController {
    
    let keyboardManager: KeyboardEventManager = KeyboardEventManager()
    let configurationManager: GlueConfigurationManager = GlueConfigurationManager.sharedInstance
    
    // MARK: - UI Componenets Outlet
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var controlLabel: NSTextField!
    @IBOutlet weak var optionLabel: NSTextField!
    @IBOutlet weak var commandLabel: NSTextField!
    @IBOutlet weak var controlButton: NSButton!
    @IBOutlet weak var optionButton: NSButton!
    @IBOutlet weak var commandButton: NSButton!
    @IBOutlet weak var usageTitleLabel: NSTextField!
    @IBOutlet weak var usageLabel: NSTextField!
    
    // MARK: - UI Componenets Action
    @IBAction func controlButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.control)
    }
    @IBAction func optionButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.option)
    }
    @IBAction func commandButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.command)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        initUIComponents()
    }
    
    private func initUIComponents() {
        // Title
        titleLabel.stringValue = "Title".localized
        controlLabel.stringValue = "Option01".localized
        optionLabel.stringValue = "Option02".localized
        commandLabel.stringValue = "Option03".localized
        controlButton.title = "OptionButton01".localized
        optionButton.title = "OptionButton02".localized
        commandButton.title = "OptionButton03".localized
        
        // Usage
        usageTitleLabel.stringValue = "UsageTitle".localized
    }
    
    private func updateStatusImage() {
        
    }
    
}

extension GlueViewController {
    static func freshController() -> GlueViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("GlueViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? GlueViewController else {
            fatalError("Why cant i find GlueViewController? - Check Main.storyboard")
        }
        viewcontroller.view.layer?.backgroundColor = CGColor.white
        return viewcontroller
    }
}
