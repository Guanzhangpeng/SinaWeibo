//
//  StatusViewModel.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/31.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {

    // MARK:- 定义属性
    var status : Status?
    
    // MARK:- 需要处理的属性
    var sourceText : String?          //处理来源
    var created_Time : String?        //处理时间
    var profileImage_Url : URL?       //处理头像地址
    var verifyImage : UIImage?        //处理用户认证图标
    var vipImage : UIImage?           //处理用户等级图标
    var picURLS :[URL] = [URL]()      //处理配图数据
    
    
    init(status : Status)
    {
        self.status = status
        
        
        //1.0 处理来源
        if let source = status.source, source != ""
        {
            // 1.1.获取起始位置和截取的长度
            let startIndex = (source as NSString).range(of: ">").location + 1
            
            let length = (source as NSString).range(of: "</").location - startIndex
            
            // 1.2.截取字符串
            sourceText = "来自 " + (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        //2.0 处理时间
        if let create_at = status.created_at
        {
            created_Time = Date.createDateFromString(timeStr: create_at)
        }
        
        //3.0 处理头像地址
        let profileUrlStr = status.user?.profile_image_url ?? ""
        profileImage_Url = URL(string: profileUrlStr)
        
        
        //4.0 处理用户认证图标
        let verifyType = status.user?.verified_type ?? -1
        switch verifyType {
        case 0:
            verifyImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifyImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifyImage = UIImage(named: "avatar_grassroot")
        default:
            verifyImage = nil
        }
        
        //5.0 处理用户等级图标
        let mbrank = status.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank <= 6
        {
            vipImage = UIImage(named:"common_icon_membership_level\(mbrank)")
        }
        
        //6.0 处理配图的数据
        if let picArray = status.pic_urls?.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        {
          for picDic in picArray
          {
            guard  let picUrl = picDic["thumbnail_pic"] else {
                continue
              }
           
            picURLS.append( URL(string: picUrl)!)
            
           }
        }
        
        
    }
}
