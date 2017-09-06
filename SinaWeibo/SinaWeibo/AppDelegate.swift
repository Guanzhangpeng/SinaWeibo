//
//  AppDelegate.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaultViewController : UIViewController
    {
        let isLogin = UserAccountViewModal.shareInstance.isLogin
        
        return isLogin ? WelcomeController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置全局属性
        UITabBar.appearance().tintColor = UIColor.orange
       
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        window = UIWindow(frame:  UIScreen.main.bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()
        return true
        
    }
}

func STWLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))----------\(messsage)")
        
    #endif
}
