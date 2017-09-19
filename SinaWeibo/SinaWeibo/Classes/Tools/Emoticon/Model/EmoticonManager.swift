//
//  EmoticonManager.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/19.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {

    var packages : [EmoticonPackage] = [EmoticonPackage]()
    
    override init() {
        //最近
        packages.append(EmoticonPackage(idStr: ""))
        
        //普通
         packages.append(EmoticonPackage(idStr: "com.sina.default"))
        
        //emoji
        packages.append(EmoticonPackage(idStr: "com.apple.emoji"))
        
        //浪小花
        packages.append(EmoticonPackage(idStr: "com.sina.lxh"))
    }
}
