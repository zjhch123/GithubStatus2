//
//  PreferencesWindow.swift
//  GithubStatus2
//
//  Created by 张佳皓 on 2017/6/29.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDisUpdate()
}


class PreferencesWindow: NSWindowController, NSWindowDelegate {

    @IBOutlet weak var usernameTextField: NSTextField!
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName: String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction func submitClicked(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.setValue(usernameTextField.stringValue, forKey: "username")
        delegate?.preferencesDisUpdate()
        self.close()
    }
    
}
