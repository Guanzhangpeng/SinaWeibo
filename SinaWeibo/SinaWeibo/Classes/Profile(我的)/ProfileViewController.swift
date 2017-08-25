//
//  ProfileViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        visitorView.setupVisitorViewInfo("visitordiscover_image_profile", "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }

}
