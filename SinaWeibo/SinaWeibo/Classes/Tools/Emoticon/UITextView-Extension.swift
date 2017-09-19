//
//  UITextView-Extension.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/19.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
extension UITextView
{
    // MARK:- 获取表情字符串
    func getEmoticonString() -> String
    {
        // 1.获取属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        
        // 2.遍历属性字符串
        let range = NSRange(location: 0, length: attrMStr.length)
        attrMStr.enumerateAttributes(in: range, options: [], using: { (dict, range, _) in
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment {
                attrMStr.replaceCharacters(in: range, with: attachment.chs!)
            }
        })
        
        // 3.获取字符串
        return attrMStr.string

    }
    // MARK:- 插入表情
    func insertEmoticon(_ emoticon : Emoticon)
    {
        //1.0如果是空白表情
        if emoticon.isEmpty
        {
            return
        }
        
        //2.0 如果是删除按钮
        if emoticon.isRemove
        {
            deleteBackward()
            return
        }
        
        //3.0 如果是emoji表情
        if  emoticon.emojiCode != nil
        {
            //获取光标所在的位置
            let textRange = selectedTextRange!
            
            replace(textRange, withText: emoticon.emojiCode!)
            
            return
        }
        
        //4.0 插入普通表情
        //创建可变的属性字符串
        let font = self.font!
        let attachment = EmoticonAttachment()
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        
        let attribeteStr = NSAttributedString(attachment: attachment)
        let range = selectedRange
        let attributeMStr = NSMutableAttributedString(attributedString: attributedText)
        attributeMStr.replaceCharacters(in: range, with: attribeteStr)
        
        //显示属性字符串
        attributedText = attributeMStr
        
        //将字体重置回去
        self.font = font
        selectedRange = NSRange(location: range.location+1, length: 0)
    }
}
