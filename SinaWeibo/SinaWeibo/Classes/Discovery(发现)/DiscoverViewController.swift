//
//  DiscoverViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo("visitordiscover_image_message", "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }
    
}
