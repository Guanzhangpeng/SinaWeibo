//
//  User.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/31.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var idstr : String?                    // 用户ID
    var screen_name : String?              // 用户昵称
    var profile_image_url :String?         // 用户头像
    var verified_type : Int = -1           // 用户的认证类型
    var mbrank :Int = 0                    // 用户的会员等级
    
    init(dict :[String:AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {  }
}
