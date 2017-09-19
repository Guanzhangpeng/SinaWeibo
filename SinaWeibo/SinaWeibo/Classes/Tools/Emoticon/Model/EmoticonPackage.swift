//
//  EmoticonPackage.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/19.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {

    var emoticons : [Emoticon] = [Emoticon]()
    
    init(idStr : String)
    {
        super.init()
        //最近分组
        if idStr == "" {
            self.addEmptyEmoticon(isRecently: true)
            return
        }
        //拼接路径
        let pathStr = Bundle.main.path(forResource: idStr + "/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        let dataDic =  NSArray(contentsOfFile: pathStr) as! [[String : String]]
        
        var index = 0
        for var item in dataDic
        {
            if let png = item["png"]
            {
                item["png"] = idStr + "/" + png
            }
            emoticons.append(Emoticon(dict: item))
            
            index += 1
            
            if index == 20 {
                //插入删除按钮
                emoticons.append(Emoticon(isRemove: true))
                index = 0
            }
        }
        
        self.addEmptyEmoticon(isRecently: false)
    }
    
    fileprivate func addEmptyEmoticon(isRecently : Bool)
    {
        let count = emoticons.count % 21
        if count == 0 && !isRecently {
            return
        }
        
        for _ in count ..< 20
        {
              emoticons.append(Emoticon(isEmpty: true))
        }
        
        emoticons.append(Emoticon(isRemove: true))
    }
}
