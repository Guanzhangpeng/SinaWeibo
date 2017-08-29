//
//  UserAccount.swift
//  SinaWeibo
//
//  Created by 郑隋 on 2017/8/28.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class UserAccount: NSObject ,NSCoding{
    
    var access_token : String?
    var expires_in   : TimeInterval = 0.0
    {
        didSet{
            expires_Date = Date(timeIntervalSinceNow: expires_in)
        }
       
    }
    var uid          : String?
    
    /// 用户头像地址
    var avatar_large : String?
    
    
    /// 用户昵称
    var screen_name  : String?
    
    /// 过期时间
    var expires_Date : Date?
    
    
    /// 自定义构造函数, 字典转模型
    init(dict : [String : AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //重写description属性
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","expires_Date","uid", "screen_name" , "avatar_large"]).description
    }
    
    // MARK:- 归档和解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        expires_Date = aDecoder.decodeObject(forKey: "expires_Date") as? Date
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(expires_Date, forKey: "expires_Date")
    }
}

