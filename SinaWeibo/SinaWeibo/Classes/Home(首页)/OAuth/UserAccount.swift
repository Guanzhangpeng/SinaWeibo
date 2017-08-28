//
//  UserAccount.swift
//  SinaWeibo
//
//  Created by 郑隋 on 2017/8/28.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    
    var access_token : String?
    var expires_in   : TimeInterval = 0.0
    {
        didSet{
            expires_Date = Date(timeIntervalSinceNow: expires_in)
        }
       
    }
    var uid          : String?
    
    var expires_Date : Date?
    
    init(dict : [String : AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //重写description属性
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","expires_Date","uid"]).description
    }
}
