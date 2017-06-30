//
//  StatusView.swift
//  GithubStatus2
//
//  Created by 张佳皓 on 2017/6/29.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Cocoa
import ServiceManagement


class StatusView: NSView, GithubRequestDelegate, PreferencesWindowDelegate  {

    
    @IBOutlet weak var popView: NSPopover!

    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var countTextField: NSTextField!
    @IBOutlet weak var logoImageView: NSImageView!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    

    
    var githubRequest: GithubRequest!
    var preferencesWindow: PreferencesWindow!
    
    override func awakeFromNib() {
        githubRequest = GithubRequest(delegate: self)
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        popView.behavior = NSPopoverBehavior.transient
        let icon = NSImage(named: "icon")
        statusItem.image = icon
        statusItem.target = self
        statusItem.action = #selector(StatusView.iconClicked)
        refreshUser()
        updateCount()
        startupAppWhenLogin(startup: Util.getDefaultStartup())
    }
    
    func refreshUser() {
        usernameTextField.stringValue = "用户：\(Util.getDefaultUser())"
    }
    
    func iconClicked() {
        updateCount()
        popView.show(relativeTo: self.statusItem.button!.bounds, of: self.statusItem.button!, preferredEdge: NSRectEdge.minY)
    }
    
    func updateCount() {
        let user = Util.getDefaultUser()
        DispatchQueue.main.async {
            self.countTextField.stringValue = "正在获取提交次数"
        }
        githubRequest.request(username: user)
    }
    
    func githubRequestDidUpdate(username: String, count: String?) {
        DispatchQueue.main.async {
            self.refreshUser()
            if let _count = count {
                self.countTextField.stringValue = "今日已提交：\(_count)次。"
            } else {
                self.countTextField.stringValue = "获取失败，请刷新重试~"
            }
        }
    }
    
    func preferencesDisUpdate() {
        refreshUser()
        startupAppWhenLogin(startup: Util.getDefaultStartup())
    }
    
    func startupAppWhenLogin(startup: Bool) {
        let launcherAppIdentifier = "com.zjh.MainAppHelper"
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, startup)
        var startedAtLogin = false
        for app in NSWorkspace.shared().runningApplications {
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
        }
        if startedAtLogin {
            DistributedNotificationCenter.default.post(name: NSNotification.Name(rawValue: "killhelper"), object: Bundle.main.bundleIdentifier!)
        }
    }
    
    @IBAction func preferencesClicked(_ sender: AnyObject) {
        preferencesWindow.showWindow(nil)
    }
    @IBAction func refreshClicked(_ sender: AnyObject) {
        updateCount()
    }
    @IBAction func quitClicked(_ sender: AnyObject) {
        NSApplication.shared().terminate(self)
    }
}
