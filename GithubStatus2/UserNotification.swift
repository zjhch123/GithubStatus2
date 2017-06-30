//
//  UserNotificationTester.swift
//  GithubStatus2
//
//  Created by 张佳皓 on 2017/6/30.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Foundation
import Cocoa

class UserNotification: NSObject, NSUserNotificationCenterDelegate, GithubRequestDelegate {
    
    var githubRequest: GithubRequest!
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    override init() {
        super.init()
        githubRequest = GithubRequest(delegate: self)
    }
    
    func checkCount() {
        githubRequest.request(username: Util.getDefaultUser())
    }
    
    func githubRequestDidUpdate(username: String, count: String?) {
        if let _count = count {
            if let __count = Int(_count) {
                if __count > 0 {
                    goodNotifaction(count: _count)
                } else {
                    badNotifaction()
                }
            } else {
                errorNotifaction()
            }
        } else {
            errorNotifaction()
        }
    }
    
    func goodNotifaction(count: String) {
        createNotifaction(title: "很棒棒!", subtitle: "今天已经提交了\(count)次代码了！明天继续保持哦~")
    }
    
    func badNotifaction() {
        createNotifaction(title: "怠惰了哦!", subtitle: "今天还没有提交代码~一定要记得提交呀!")
    }
    
    func errorNotifaction() {
        createNotifaction(title: "出错啦!", subtitle: "获取提交状态失败，请手动检查!")
    }
    
    func createNotifaction(title: String, subtitle: String) {
        let userNotification = NSUserNotification()
        // userNotification.contentImage = NSImage(named: "img")
        userNotification.title = title
        userNotification.subtitle = subtitle
        let userNotificationCenter = NSUserNotificationCenter.default
        userNotificationCenter.delegate = self
        userNotificationCenter.scheduleNotification(userNotification)
    }
    
}
