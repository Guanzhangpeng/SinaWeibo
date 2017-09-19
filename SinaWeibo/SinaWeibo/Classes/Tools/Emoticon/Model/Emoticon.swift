//
//  Emoticon.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/19.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class Emoticon :NSObject {

    // MARK:- 定义属性
    var code : String? {     // emoji的code
        didSet{
            guard let code = code else {
                return
            }
            
            // 1.创建扫描器
            let scanner = Scanner(string: code)
            
            // 2.调用方法,扫描出code中的值
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            
            // 3.将value转成字符
            let c = Character(UnicodeScalar(value)!)
            
            // 4.将字符转成字符串
            emojiCode = String(c)
        }
    }
    var png : String? {      // 普通表情对应的图片名称
        didSet{
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
            
        }
    }
    var chs : String?       // 普通表情对应的文字 
    
    //数据处理
    var pngPath : String?
    var emojiCode :String?
    var isRemove : Bool = false
    var isEmpty : Bool = false
    
    init(isRemove : Bool)
    {
        self.isRemove = isRemove
    }
    
    init(isEmpty : Bool)
    {
        self.isEmpty = isEmpty
    }
    
    init(dict : [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String
    {
        return dictionaryWithValues(forKeys: ["emojiCode","pngPath","chs"]).description
    }
    
}
