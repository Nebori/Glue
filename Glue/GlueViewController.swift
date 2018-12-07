//
//  GlueViewController.swift
//  Glue
//
//  Created by 김인중 on 03/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

class GlueViewController: NSViewController {
    
    let disableOpacity: CGFloat = 0.3
    let ableOpacity: CGFloat = 1
    
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
    
    // Usage
    @IBOutlet weak var usageTitleLabel: NSTextField!
    @IBOutlet weak var usageLabel: NSTextField!
    @IBOutlet weak var upLabel: NSTextField!
    @IBOutlet weak var downLabel: NSTextField!
    @IBOutlet weak var rightLabel: NSTextField!
    @IBOutlet weak var leftLabel: NSTextField!
    @IBOutlet weak var rightUpLabel: NSTextField!
    @IBOutlet weak var leftUpLabel: NSTextField!
    @IBOutlet weak var rightDownLabel: NSTextField!
    @IBOutlet weak var leftDownLabel: NSTextField!
    
    // MARK: - UI Componenets Action
    @IBAction func controlButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.control)
        updateUIStatus()
        updateWarningStatus()
        updateUsage()
    }
    @IBAction func optionButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.option)
        updateUIStatus()
        updateWarningStatus()
        updateUsage()
    }
    @IBAction func commandButtonAction(_ sender: Any) {
        configurationManager.changeConfig(.command)
        updateUIStatus()
        updateWarningStatus()
        updateUsage()
    }
    @IBAction func quitButtonAction(_ sender: Any) {
        exit(0)
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
        let config = configurationManager.config
        if config.control {
            controlLabel.alphaValue = ableOpacity
        } else {
            controlLabel.alphaValue = disableOpacity
        }
        if config.option {
            optionLabel.alphaValue = ableOpacity
        } else {
            optionLabel.alphaValue = disableOpacity
        }
        if config.command {
            commandLabel.alphaValue = ableOpacity
        } else {
            commandLabel.alphaValue = disableOpacity
        }
        upLabel.stringValue = config.up.getString()
        downLabel.stringValue = config.down.getString()
        rightLabel.stringValue = config.right.getString()
        leftLabel.stringValue = config.left.getString()
        rightUpLabel.stringValue = config.rightUp.getString()
        leftUpLabel.stringValue = config.leftUp.getString()
        rightDownLabel.stringValue = config.rightDown.getString()
        leftDownLabel.stringValue = config.leftDown.getString()
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
        let usage = configurationManager.getUsage()
        usageLabel.stringValue = usage
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
