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

    @IBOutlet weak var startupBtn: NSButton!
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
        let defaults = UserDefaults.standard
        
        var user: String!
        if let _user = defaults.string(forKey: "username") {
            user = _user
        } else {
            user = "octocat"
        }

        let startup: Bool = defaults.bool(forKey: "startup")
        
        usernameTextField.stringValue = user
        startupBtn.state = startup ? 1 : 0
    }
    
    @IBAction func submitClicked(_ sender: AnyObject) {
        if(usernameTextField.stringValue != Util.getDefaultUser()) {
            // 如果更新了账号，则刷新今日提醒
            Util.setTodayNotifaction(flag: false)
        }
        
        Util.setDefaultUser(username: usernameTextField.stringValue)
        Util.setDefaultStartup(startup: startupBtn.state)
        delegate?.preferencesDisUpdate()
        self.close()
    }
    
}
