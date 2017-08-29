//
//  UserAccountViewModal.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/29.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class UserAccountViewModal: NSObject {

    static let shareInstance : UserAccountViewModal = UserAccountViewModal()
    // MARK:- 用户属性
    var userAccount : UserAccount?
    
    //文件路径
    var filePath : String
    {
        let  filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return filePath.appending("/account.plist")
    }
    
    var isLogin : Bool{
        
        if userAccount == nil
        {
            return false
        }
        
        guard let expires_Date = userAccount?.expires_Date else {
            return false
        }
        return expires_Date.compare(Date()) == .orderedDescending
     
    }
    
    //从沙盒中读取用户信息
    override init()
    {
        super.init()
        self.userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? UserAccount
    }
}
