//
//  ExNSColor.swift
//  GithubStatus2
//
//  Created by 张佳皓 on 2017/6/30.
//  Copyright © 2017年 张佳皓. All rights reserved.
//

import Foundation
import Cocoa
// MARK: - 给UIColor写两个类方法
extension NSColor {
    /**
     16进制转UIColor
     
     - parameter hex: 16进制颜色字符串
     
     - returns: 转换后的颜色
     */
    class func ColorHex(hex: String) -> NSColor {
        return proceesHex(hex: hex, alpha: 1.0)
    }
    
    /**
     16进制转UIColor，
     
     - parameter hex:   16进制颜色字符串
     - parameter alpha: 透明度
     
     - returns: 转换后的颜色
     */
    class func ColorHexWithAlpha(hex: String, alpha: CGFloat) -> NSColor {
        return proceesHex(hex: hex, alpha: alpha)
    }
}

// MARK: - 主要逻辑
private func proceesHex(hex: String, alpha: CGFloat) -> NSColor{
    /** 如果传入的字符串为空 */
    if hex.isEmpty {
        return NSColor.clear
    }
    
    
    /**
     结合swift3.0 语法，修改后的逻辑实现
     */
    
    
    /** 传进来的值。 去掉了可能包含的空格、特殊字符， 并且全部转换为大写 */
    let set = CharacterSet.whitespacesAndNewlines
    var hHex = hex.trimmingCharacters(in: set).uppercased()
    
    /** 如果处理过后的字符串少于6位 */
    if hHex.characters.count < 6 {
        return NSColor.clear
    }
    
    /** 开头是用0x开始的 */
    if hHex.hasPrefix("0X") {
        hHex = (hHex as NSString).substring(from: 2)
    }
    /** 开头是以＃开头的 */
    if hHex.hasPrefix("#") {
        hHex = (hHex as NSString).substring(from: 1)
    }
    /** 开头是以＃＃开始的 */
    if hHex.hasPrefix("##") {
        hHex = (hHex as NSString).substring(from: 2)
    }
    
    /** 截取出来的有效长度是6位， 所以不是6位的直接返回 */
    if hHex.characters.count != 6 {
        return NSColor.clear
    }
    
    /** R G B */
    var range = NSMakeRange(0, 2)
    
    /** R */
    let rHex = (hHex as NSString).substring(with: range)
    
    /** G */
    range.location = 2
    let gHex = (hHex as NSString).substring(with: range)
    
    /** B */
    range.location = 4
    let bHex = (hHex as NSString).substring(with: range)
    
    /** 类型转换 */
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    
    Scanner(string: rHex).scanHexInt32(&r)
    Scanner(string: gHex).scanHexInt32(&g)
    Scanner(string: bHex).scanHexInt32(&b)
    
    return NSColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
}
