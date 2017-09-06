//
//  STWTabBarController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class STWTabBarController: UITabBarController {

    
    // MARK:- 数据懒加载
    fileprivate lazy var composeButton : UIButton = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeButton()
    }
}

extension STWTabBarController
{

    fileprivate func setupComposeButton()
    {
        tabBar.addSubview(composeButton)
        composeButton.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        composeButton.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
        
    }
}

extension STWTabBarController
{
    @objc fileprivate func composeButtonClick()
    {
        let nav = UINavigationController(rootViewController: ComposeViewController())
        present(nav, animated: true, completion: nil)
    }
}
