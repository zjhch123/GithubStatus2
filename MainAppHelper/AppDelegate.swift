//
//  AppDelegate.swift
//  MainAppHelper
//
//  Created by 张佳皓 on 2017/6/30.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = "com.zjh.GithubStatus2"
        let running = NSWorkspace.shared().runningApplications
        var alreadyRunning = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(AppDelegate.terminate), name: NSNotification.Name(rawValue: "killhelper"), object: mainAppIdentifier)
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("GithubStatus2") //main app name
            
            let newPath = NSString.path(withComponents: components)
            NSWorkspace.shared().launchApplication(newPath)
        } else {
            self.terminate()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func terminate() {
        NSApp.terminate(nil)
    }

}

