//
//  StatusView.swift
//  GithubStatus2
//
//  Created by 张佳皓 on 2017/6/29.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Cocoa

class StatusView: NSView {

    
    @IBOutlet weak var popView: NSPopover!

    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var countTextField: NSTextField!
    @IBOutlet weak var logoImageView: NSImageView!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    
    var githubRequest: GithubRequest!
    var preferencesWindow: PreferencesWindow!
    var userNotification: UserNotification!
    
    override func awakeFromNib() {
        launchVariable()
        launchStatusItem()
        refreshUser()
        updateCount()
        startupAppWhenLogin(startup: Util.getDefaultStartup())
        userNotification = UserNotification()
        let cycyleTimer = Timer(timeInterval: 10, target: self, selector: #selector(self.timer), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer, forMode:RunLoopMode.commonModes)
    
        Util.setTodayNotifaction(flag: false)
        
    }
    
    func timer() {
        let currentdate = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year,.month, .day, .hour,.minute,.second], from: currentdate )
        if dateComponents.hour! >= 20 && !Util.todayIsNotifaction() {
            userNotification.checkCount()
            Util.setTodayNotifaction(flag: true)
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
