//
//  STWTabBarController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class STWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我的", imageName: "tabbar_profile")
    }
    
    func addChildViewController(_ childVc: UIViewController , title : String , imageName : String) {
        
        //设置自控制的属性
        childVc.title =  title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        
        //包装导航控制器
        let nav = UINavigationController(rootViewController: childVc)
        
        //添加自控制器
        addChildViewController(nav)
    }
}
