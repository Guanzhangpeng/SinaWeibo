//
//  FindEmoticon.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/20.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    
    // MARK:- 懒加载方法
    static let shareInstance = FindEmoticon()
    
    fileprivate lazy var manager : EmoticonManager = EmoticonManager()
    
    // MARK:- 查找属性字符串的方法
    func findEmoticonString(statusText : String? , font : UIFont) -> NSMutableAttributedString?
    {
        
        guard let statusText = statusText else {
            return nil
        }
        
        //1.0 创建正则匹配规则
        let pattern = "\\[.*?\\]"
        
        //2.0 创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        //3.0 开始匹配
        let results = regex.matches(in: statusText, options: [], range: NSRange(location: 0, length: statusText.characters.count)).reversed()
        
        //4.0 获取匹配结果
        let attribueMStr = NSMutableAttributedString(string: statusText)
        
        for result in results {
            
            //4.1 获取chs
            let chs = (statusText as NSString).substring(with: result.range)
            
            //4.2 根据chs获取图片路径
            guard let pngPath = findPngPath(chs: chs) else {
                
                return nil
            }
            
            //4.3 创建时属性字符串
            let attachment = NSTextAttachment()
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            attachment.image = UIImage(contentsOfFile: pngPath)
            
            let attributeImgStr = NSAttributedString(attachment: attachment)
            
            attribueMStr.replaceCharacters(in: result.range, with: attributeImgStr)
        }
        return attribueMStr
    }
    
    // MARK:- 根据chs获取表情路径
    func findPngPath(chs : String) -> String?
    {
        for package in manager.packages
        {
            for emoticon in package.emoticons
            {
                if  emoticon.chs == chs
                {
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}
