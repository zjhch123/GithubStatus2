//
//  Util.swift
//  GithubStatus2
//
//  Created by 张佳皓 on 2017/6/30.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Foundation

struct Util {
    
    static let DEFAULT_USER = "octocat"
    
    static func setDefaultUser(username: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(username, forKey: "username")
    }
    
    static func setDefaultStartup(startup: Int) {
        let defaults = UserDefaults.standard
        defaults.setValue(startup == 1, forKey: "startup")
    }
    
    static func getDefaultUser() -> String {
        let defaults = UserDefaults.standard
        let user = defaults.string(forKey: "username") ?? DEFAULT_USER
        return user
    }
    
    static func getDefaultStartup() -> Bool {
        let defaults = UserDefaults.standard
        let startup = defaults.bool(forKey: "startup")
        return startup
    }
    
}
