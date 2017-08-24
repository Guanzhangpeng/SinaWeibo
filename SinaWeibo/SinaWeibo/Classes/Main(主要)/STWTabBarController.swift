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
//        addChildViewController("HomeViewController", title: "首页", imageName: "tabbar_home")
//        addChildViewController("MessageViewController", title: "消息", imageName: "tabbar_message_center")
//        addChildViewController("DiscoverViewController", title: "发现", imageName: "tabbar_discover")
//        addChildViewController("ProfileViewController", title: "我的", imageName: "tabbar_profile")

        // 获取文件路径
        guard let filePath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            STWLog("没有找到MainVCSettings.json对应的文件")
            return
        }
        
        // 读取文件数据
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            STWLog("读取二进制文件失败")
            return
        }

        //将json数据转换成 数组格式
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) , let jsonArray = json as? [[String : AnyObject]] else {
            STWLog("读取文件失败")
            return
        }
        
        jsonArray.forEach{
            
            guard let vcName = $0["vcName"] as? String else {
                return
            }
            guard let title = $0["title"] as? String else {
                return
            }
            guard let imageName = $0["imageName"] as? String else {
                return
            }
            
            addChildViewController(vcName, title: title, imageName: imageName)
        
        }
    }
    
    func addChildViewController(_ childClassString: String , title : String , imageName : String) {
        
        //获取命名空间名称并且拼接字符串 然后转化成对应的Class类型
       guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String , let childClass = NSClassFromString(nameSpace + "." + childClassString) else
       {
         STWLog("没有获取到字符串对应的Class")
         return
       }
        
        // 将对应的anyclass类型转换成控制器类型
      guard  let childVcType = childClass as? UIViewController.Type else
      {
        STWLog("没有获取到对应控制器的类型")
        return
      }
        
        //将childVcType 转换成对应的控制器
       let childVc = childVcType.init()
        
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
