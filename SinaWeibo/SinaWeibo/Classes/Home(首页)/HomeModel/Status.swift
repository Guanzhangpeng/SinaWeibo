//
//  Status.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/30.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var created_at : String?            /// 微博的创建时间
    var text : String?                  /// 微博正文
    var mid  : Int = 0                  /// 微博ID
    var source : String?                /// 微博来源
    var user  : User?                   /// 用户信息
    var retweeted_status : Status?      /// 转发微博
    var pic_urls : [[String: String]]?  /// 配图
    
    // MARK:- 字典转模型
    init(dict : [String : AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
        if let userDict = dict["user"] as? [String:AnyObject]
        {
            user = User(dict: userDict)
        }
        if let retweetedStatus = dict["retweeted_status"] as? [String:AnyObject]
        {
            retweeted_status = Status(dict: retweetedStatus)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
