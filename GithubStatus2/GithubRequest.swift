//
//  GithubRequest.swift
//  GithubStatus
//
//  Created by 张佳皓 on 2017/6/29.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Foundation
import SwiftHTTP
import Regex

protocol GithubRequestDelegate {
    func githubRequestDidUpdate(username: String, count: String?)
}

class GithubRequest {
    
    var delegate: GithubRequestDelegate?
    
    init(delegate: GithubRequestDelegate) {
        self.delegate = delegate
    }
    
    func getCountFrom(html: String) -> String? {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let stringDate = dateFormatter.string(from: currentDate)
        let pattern = "data-count=\"(\\d{1,})\" data-date=\"\(stringDate)\""
        let digit = pattern.r?.findFirst(in: html)?.group(at: 1)
        print(digit)
        return digit
    }
    
    func getCountFrom(html: String, username: String) {
        let digit = getCountFrom(html: html)
        self.delegate?.githubRequestDidUpdate(username: username, count: digit)
    }
    
    func request(username: String) {
        let headers = [
            "Host": "github.com",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            "Accept-Encoding": "gzip, deflate, sdch, br",
            "Cookie": "tz=Asia/Shanghai"
        ]
        do {
            let opt = try HTTP.GET("https://github.com/" + username, headers: headers)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                print("ok")
                self.getCountFrom(html: response.description, username: username)
            }
        } catch let error {
            print("an error occur: \(error.localizedDescription)")
        }
    }
    
}
