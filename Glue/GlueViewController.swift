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
    @IBOutlet weak var warningLabel: NSTextField!
    @IBOutlet weak var usageTitleLabel: NSTextField!
    @IBOutlet weak var usageLabel: NSTextField!
    
    // MARK: - UI Componenets Action
    @IBAction func controlButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.control)
        updateWarningStatus()
        updateUsage()
    }
    @IBAction func optionButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.option)
        updateWarningStatus()
        updateUsage()
    }
    @IBAction func commandButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.command)
        updateWarningStatus()
        updateUsage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        initUIComponents()
        updateUIStatus()
        updateWarningStatus()
        updateUsage()
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
        warningLabel.stringValue = "Warning".localized
        warningLabel.isHidden = true
        
        // Usage
        usageTitleLabel.stringValue = "UsageTitle".localized
    }
    
    private func updateUIStatus() {
        
    }
    
    private func updateWarningStatus() {
        let config = configurationManager.config
        if configurationManager.getOnCount() == 1 {
            if config.control {
                changeRestButtonStatus(.control)
            } else if config.option {
                changeRestButtonStatus(.option)
            } else if config.command {
                changeRestButtonStatus(.command)
            }
            warningLabel.isHidden = false
        } else {
            controlButton.isEnabled = true
            optionButton.isEnabled = true
            commandButton.isEnabled = true
            warningLabel.isHidden = true
        }
    }
    
    private func updateUsage() {
        let usageSuffix = configurationManager.getUsage()
        usageLabel.stringValue = "\(usageSuffix) + " + "Usage".localized
    }
    
    private func changeRestButtonStatus(_ category: GlueConfigCategory) {
        switch category {
        case .control:
            controlButton.isEnabled = false
        case .option:
            optionButton.isEnabled = false
        case .command:
            commandButton.isEnabled = false
        }
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
