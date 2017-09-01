//
//  Date-Extension.swift
//  DateDeal
//
//  Created by 管章鹏 on 2017/8/31.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import Foundation

extension Date
{
    static func createDateFromString(timeStr : String) -> String
    {
        
        //1.0 创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        guard let createDate = fmt.date(from: timeStr) else {
            return ""
        }
        //2.0 计算当前时间和创建时间的时间差
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        //3.0 对时间间隔进行处理
        
        //3.1 显示刚刚
        if interval < 60
        {
            return "刚刚"
        }
        
        //3.2 59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        //3.3 11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 3.4 处理昨天数据
        let calendar = Calendar.current
        
        if calendar.isDateInYesterday(createDate)
        {
            fmt.dateFormat = "昨天 HH:mm"
            return fmt.string(from: createDate)
        }
        
        // 3.5 处理一年以内 06-22 14:22
        let coms = calendar.dateComponents([.year], from: createDate, to: nowDate)
        
        if  coms.year! < 1
        {
            fmt.dateFormat = "MM-dd HH:mm"
            return fmt.string(from: createDate)
        }
        
        //3.6 处理一年以上的数据  2013-05-17 14:32
        fmt.dateFormat = "YYYY-MM-dd HH:mm"
        return fmt.string(from: createDate)
    }
}
