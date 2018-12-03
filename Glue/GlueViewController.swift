//
//  GlueViewController.swift
//  Glue
//
//  Created by 김인중 on 03/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

class GlueViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension GlueViewController {
    static func freshController() -> GlueViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("GlueViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? GlueViewController else {
            fatalError("Why cant i find GlueViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
